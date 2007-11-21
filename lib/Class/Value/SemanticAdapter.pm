package Class::Value::SemanticAdapter;

use strict;
use warnings;
use UNIVERSAL::require;


our $VERSION = '0.01';


use base qw(Class::Value);


# Default; subclasses can redefine this. But it makes sense to keep the
# Data::Domain::* and Data::Semantic::* namespaces in sync.

sub semantic_class_name {
    my $self = shift;
    (my $semantic_class_name = ref $self) =~
        s/^Class::Value::/Data::Semantic::/;
    $semantic_class_name;
}


# FIXME might cache the adaptee unless $self->dirty;

sub adaptee {
    my $self = shift;
    my $semantic_class_name = $self->semantic_class_name;
    $semantic_class_name->require;
    $semantic_class_name->new($self->semantic_args);
}


# Return those of the value object's attributes that are relevant to the
# semantic data object constructor.

sub semantic_args { () }


sub is_valid_value {
    my ($self, $value) = @_;
    $self->adaptee->is_valid($value);
}


sub normalize_value {
    my ($self, $value) = @_;
    $self->adaptee->normalize($value);
}


sub is_valid_normalized_value {
    my ($self, $normalized) = @_;
    $self->adaptee->is_valid_normalized_value($normalized);
}


1;


__END__



=head1 NAME

Class::Value::SemanticAdapter - Adapter for Data::Semantic objects

=head1 SYNOPSIS

    Class::Value::SemanticAdapter->new;

=head1 DESCRIPTION

This class is an adapter (wrapper) that turns L<Data::Semantic> objects into
L<Class::Value> objects.

Class::Value::SemanticAdapter inherits from L<Class::Value>.

The superclass L<Class::Value> defines these methods and functions:

    new(), (""(), (%(), (&(), ()(), (*(), (**(), (+(), (-(), (/(), (<<(),
    (<=>(), (<>(), (>>(), (^(), (atan2(), (cmp(), (cos(), (exp(), (int(),
    (log(), (sin(), (sqrt(), (|(), (~(), DEFAULTS(),
    FIRST_CONSTRUCTOR_ARGS(), MUNGE_CONSTRUCTOR_ARGS(), UNHYGIENIC(),
    add(), atan2(), bit_and(), bit_not(), bit_or(), bit_shift_left(),
    bit_shift_right(), bit_xor(), check(), clear_exception_container(),
    clear_notify_delegate(), comparable(), cos(), divide(), except(),
    exception_container(), exception_container_clear(), exp(), finally(),
    get_value(), init(), int(), is_defined(), is_valid(), is_well_formed(),
    is_well_formed_value(), iterate(), log(), modulo(), multiply(),
    normalize(), notify_delegate(), notify_delegate_clear(), num_cmp(),
    otherwise(), power(), run_checks(),
    run_checks_with_exception_container(), send_notify_value_invalid(),
    send_notify_value_normalized(), send_notify_value_not_wellformed(),
    set_value(), sin(), skip_checks(), skip_dirtying(),
    skip_normalizations(), sqrt(), str_cmp(), stringify(), subtract(),
    throw_single_exception(), try(), value(), with()

The superclass L<Class::Accessor::Complex> defines these methods and
functions:

    carp(), cluck(), croak(), flatten(), mk_abstract_accessors(),
    mk_array_accessors(), mk_boolean_accessors(),
    mk_class_array_accessors(), mk_class_hash_accessors(),
    mk_class_scalar_accessors(), mk_concat_accessors(),
    mk_forward_accessors(), mk_hash_accessors(), mk_integer_accessors(),
    mk_new(), mk_object_accessors(), mk_scalar_accessors(),
    mk_set_accessors(), mk_singleton()

The superclass L<Class::Accessor> defines these methods and functions:

    _carp(), _croak(), _mk_accessors(), accessor_name_for(),
    best_practice_accessor_name_for(), best_practice_mutator_name_for(),
    follow_best_practice(), get(), make_accessor(), make_ro_accessor(),
    make_wo_accessor(), mk_accessors(), mk_ro_accessors(),
    mk_wo_accessors(), mutator_name_for(), set()

The superclass L<Class::Accessor::Installer> defines these methods and
functions:

    install_accessor(), subname()

The superclass L<Class::Accessor::Constructor> defines these methods and
functions:

    NO_DIRTY(), WITH_DIRTY(), _make_constructor(), mk_constructor(),
    mk_constructor_with_dirty(), mk_singleton_constructor()

The superclass L<Data::Inherited> defines these methods and functions:

    every_hash(), every_list(), flush_every_cache_by_key()

The superclass L<Class::Accessor::Constructor::Base> defines these methods
and functions:

    HYGIENIC(), STORE(), clear_dirty(), clear_hygienic(),
    clear_unhygienic(), contains_hygienic(), contains_unhygienic(),
    delete_hygienic(), delete_unhygienic(), dirty(), dirty_clear(),
    dirty_set(), elements_hygienic(), elements_unhygienic(), hygienic(),
    hygienic_clear(), hygienic_contains(), hygienic_delete(),
    hygienic_elements(), hygienic_insert(), hygienic_is_empty(),
    hygienic_size(), insert_hygienic(), insert_unhygienic(),
    is_empty_hygienic(), is_empty_unhygienic(), set_dirty(),
    size_hygienic(), size_unhygienic(), unhygienic(), unhygienic_clear(),
    unhygienic_contains(), unhygienic_delete(), unhygienic_elements(),
    unhygienic_insert(), unhygienic_is_empty(), unhygienic_size()

The superclass L<Tie::StdHash> defines these methods and functions:

    CLEAR(), DELETE(), EXISTS(), FETCH(), FIRSTKEY(), NEXTKEY(), SCALAR(),
    TIEHASH()

=head1 METHODS

=over 4



=item semantic_class_name

Returns the corresponding semantic class name. This method provides a default
mapping, the idea of which is to mirror the layout of the Data::Semantic class
tree. If you have a different mapping, override this method in a subclass.

So in the Class::Value::URI::http class, it will return
C<Data::Semantic::URI::http>.

=item adaptee

Takes the results of C<semantic_class_name()> and C<semantic_args()>, loads
the semantic data class and returns a semantic data object with the given args
passed to its constructor.

=item semantic_args

Return those of the value object's attributes, in hash format, that are
relevant to the semantic data object constructor.

=item is_valid_value

Like the same method in L<Class::Value>, but forwards the question to the
adapted data semantic object.

=item normalize_value

Like the same method in L<Class::Value>, but forwards the question to the
adapted data semantic object.

=item is_valid_normalized_value

Like the same method in L<Class::Value>, but forwards the question to the
adapted data semantic object.

=back

=head1 TAGS

If you talk about this module in blogs, on del.icio.us or anywhere else,
please use the C<classvaluesemanticadapter> tag.

=head1 VERSION 
                   
This document describes version 0.01 of L<Class::Value::SemanticAdapter>.

=head1 BUGS AND LIMITATIONS

No bugs have been reported.

Please report any bugs or feature requests to
C<<bug-class-value-semanticadapter@rt.cpan.org>>, or through the web interface at
L<http://rt.cpan.org>.

=head1 INSTALLATION

See perlmodinstall for information and options on installing Perl modules.

=head1 AVAILABILITY

The latest version of this module is available from the Comprehensive Perl
Archive Network (CPAN). Visit <http://www.perl.com/CPAN/> to find a CPAN
site near you. Or see <http://www.perl.com/CPAN/authors/id/M/MA/MARCEL/>.

=head1 AUTHOR

Marcel GrE<uuml>nauer, C<< <marcel@cpan.org> >>

=head1 COPYRIGHT AND LICENSE

Copyright 2007 by Marcel GrE<uuml>nauer

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.


=cut

