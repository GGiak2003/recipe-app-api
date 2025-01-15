"""
Serializers for the user API view.
"""
from django.contrib.auth import get_user_model

from rest_framework import serializers


class UserSerializer(serializers.ModelSerializer):
    """Serializers for the user object."""

    class Meta:
        model = get_user_model
        fields = ['email', 'password', 'name']
        extra_kwargs = {'password': {'write_only': True, 'min_lenght': 5}}

    def create(self, validated_data):
        """Create and return a user with encrypted password."""
        return get_user_model().objects.create_user(**validated_data)