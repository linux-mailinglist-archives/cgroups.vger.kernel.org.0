Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 11002180610
	for <lists+cgroups@lfdr.de>; Tue, 10 Mar 2020 19:20:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726414AbgCJSUx (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 10 Mar 2020 14:20:53 -0400
Received: from wout1-smtp.messagingengine.com ([64.147.123.24]:52941 "EHLO
        wout1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726403AbgCJSUw (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 10 Mar 2020 14:20:52 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.west.internal (Postfix) with ESMTP id B55B0A1E;
        Tue, 10 Mar 2020 14:20:50 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Tue, 10 Mar 2020 14:20:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dxuuu.xyz; h=
        content-transfer-encoding:content-type:in-reply-to:date:from:to
        :cc:subject:message-id; s=fm2; bh=5FlyFofPg7aTv586jLAdhujdZkMVwt
        aTjltq0mF7OD8=; b=xafPDPpdBEzAXboC3WYjQSk+mV62smjUftt64gACW+cqGt
        DY8Phzta7VFFjeCpoi7FJdgH/SyE+Md2cIFy9+YXBY3cMvJ6bpwchWu0c1a961LE
        VhldM8gONOE7T+y9GoJDQg4MGwroYLlhNAlcqzaWY1RlPVWy7biAiBnI8OYPx+N8
        Eo+psPb6sqNiud9CNJKC8+WCqWvnkGCFmFLoFl97Wes0FpjTA9p4rvwuJpNM/Gz8
        XEQf9m8bC2y6JyFVFgN0WrriCDG9r5SWlQCYNbqOv3tendXIjfYNQHd7gCnGVC6M
        6NoFHPpRZqu1FjZHdfhNKxG/oBay4qAUSN2SZueQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=5FlyFo
        fPg7aTv586jLAdhujdZkMVwtaTjltq0mF7OD8=; b=m+m1A427Im9IndTacGJN53
        l3uFWjdDGVJgIJERUsd8aO6kPEy3U0s565d+ThVRcz1GdpdziGnJWD4S9Md6pInU
        ivy9e7yLt7d/DLkQ0ibHSHwyDUg7HB0toh5vIb/WtFYDN5xczG/On08I6P73lp1L
        PMgD2uuBWvSm0XWQjP1dUpp5iwc5G4cN9hwZMBazyRDkfGg6OKFbxTgj/wKHevxX
        dRmd/d53V63SxH/63KnU7gjKQ7NoXbdHUXNzkAWVq5JZgCB2R9Fe+sXH2fEAH7Ek
        3rWm6xUKoe3uRofBvIQ1BLV8CLjSE7xQVsi2wf3M1ImPgJVtWwM2OIFmNGYA/X6w
        ==
X-ME-Sender: <xms:gNpnXiRj5Bkn0n8XO9jZldOEbHnymVtVSzy5OxI_czg_hifPSl3VZw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedugedruddvtddguddtgecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecufghrlhcuvffnffculdejtddmnecujfgurhepgf
    gtjgffhffvuffksehtqhertddttdejnecuhfhrohhmpedfffgrnhhivghlucgiuhdfuceo
    ugiguhesugiguhhuuhdrgiihiieqnecukfhppeduieefrdduudegrddufedvrdegnecuve
    hluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepugiguhesugig
    uhhuuhdrgiihii
X-ME-Proxy: <xmx:gNpnXg2E7y1dFQZ6anQRXj86HCrlE3KlSx-lW5qjUcd4gDc5SHHrfg>
    <xmx:gNpnXo5EB8YP-l9x_7gEorJARrU8HOgYdiQWe80a-fvxRELljZ4XHQ>
    <xmx:gNpnXpxDelC8K5q42QJRwAZrWz-aJivPyGkGReTk9fH6_ZRC8nooIQ>
    <xmx:gtpnXo-av3gvW-TjackCuZj1MEjfFPKZ6TNkEUdNM-t7gX2GoK8sgQ>
Received: from localhost (unknown [163.114.132.4])
        by mail.messagingengine.com (Postfix) with ESMTPA id 9443130614B1;
        Tue, 10 Mar 2020 14:20:45 -0400 (EDT)
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Originaldate: Thu Mar 5, 2020 at 1:16 PM
Originalfrom: "Daniel Xu" <dxu@dxuuu.xyz>
Original: =?utf-8?q?This_helps_set_up_size_accounting_in_the_next_commit._Without_t?=
 =?utf-8?q?his_out=0D=0Aparam,_it's_difficult_to_find_out_the_removed_xatt?=
 =?utf-8?q?r_size_without_taking=0D=0Aa_lock_for_longer_and_walking_the_xa?=
 =?utf-8?q?ttr_linked_list_twice.=0D=0A=0D=0ASigned-off-by:_Daniel_Xu_<dxu?=
 =?utf-8?q?@dxuuu.xyz>=0D=0A---=0D=0A_fs/kernfs/inode.c_____|__2_+-=0D=0A_?=
 =?utf-8?q?fs/xattr.c____________|_11_++++++++++-=0D=0A_include/linux/xatt?=
 =?utf-8?q?r.h_|__3_++-=0D=0A_mm/shmem.c____________|__2_+-=0D=0A_4_files_?=
 =?utf-8?q?changed,_14_insertions(+),_4_deletions(-)=0D=0A=0D=0Adiff_--git?=
 =?utf-8?q?_a/fs/kernfs/inode.c_b/fs/kernfs/inode.c=0D=0Aindex_d0f7a5abd9a?=
 =?utf-8?q?9..5f10ae95fbfa_100644=0D=0A---_a/fs/kernfs/inode.c=0D=0A+++_b/?=
 =?utf-8?q?fs/kernfs/inode.c=0D=0A@@_-303,7_+303,7_@@_int_kernfs=5Fxattr?=
 =?utf-8?q?=5Fset(struct_kernfs=5Fnode_*kn,_const_char_*name,=0D=0A_=09if_?=
 =?utf-8?q?(!attrs)=0D=0A_=09=09return_-ENOMEM;=0D=0A_=0D=0A-=09return_sim?=
 =?utf-8?q?ple=5Fxattr=5Fset(&attrs->xattrs,_name,_value,_size,_flags);=0D?=
 =?utf-8?q?=0A+=09return_simple=5Fxattr=5Fset(&attrs->xattrs,_name,_value,?=
 =?utf-8?q?_size,_flags,_NULL);=0D=0A_}=0D=0A_=0D=0A_static_int_kernfs=5Fv?=
 =?utf-8?q?fs=5Fxattr=5Fget(const_struct_xattr=5Fhandler_*handler,=0D=0Adi?=
 =?utf-8?q?ff_--git_a/fs/xattr.c_b/fs/xattr.c=0D=0Aindex_0d3c9b4d1914..e13?=
 =?utf-8?q?265e65871_100644=0D=0A---_a/fs/xattr.c=0D=0A+++_b/fs/xattr.c=0D?=
 =?utf-8?q?=0A@@_-860,6_+860,7_@@_int_simple=5Fxattr=5Fget(struct_simple?=
 =?utf-8?q?=5Fxattrs_*xattrs,_const_char_*name,=0D=0A__*_@value:_value_of_?=
 =?utf-8?q?the_xattr._If_%NULL,_will_remove_the_attribute.=0D=0A__*_@size:?=
 =?utf-8?q?_size_of_the_new_xattr=0D=0A__*_@flags:_%XATTR=5F{CREATE|REPLAC?=
 =?utf-8?q?E}=0D=0A+_*_@removed=5Fsize:_returns_size_of_the_removed_xattr,?=
 =?utf-8?q?_-1_if_none_removed=0D=0A__*=0D=0A__*_%XATTR=5FCREATE_is_set,_t?=
 =?utf-8?q?he_xattr_shouldn't_exist_already;_otherwise_fails=0D=0A__*_with?=
 =?utf-8?q?_-EEXIST.__If_%XATTR=5FREPLACE_is_set,_the_xattr_should_exist;?=
 =?utf-8?q?=0D=0A@@_-868,7_+869,8_@@_int_simple=5Fxattr=5Fget(struct_simpl?=
 =?utf-8?q?e=5Fxattrs_*xattrs,_const_char_*name,=0D=0A__*_Returns_0_on_suc?=
 =?utf-8?q?cess,_-errno_on_failure.=0D=0A__*/=0D=0A_int_simple=5Fxattr=5Fs?=
 =?utf-8?q?et(struct_simple=5Fxattrs_*xattrs,_const_char_*name,=0D=0A-=09?=
 =?utf-8?q?=09_____const_void_*value,_size=5Ft_size,_int_flags)=0D=0A+=09?=
 =?utf-8?q?=09_____const_void_*value,_size=5Ft_size,_int_flags,=0D=0A+=09?=
 =?utf-8?q?=09_____ssize=5Ft_*removed=5Fsize)=0D=0A_{=0D=0A_=09struct_simp?=
 =?utf-8?q?le=5Fxattr_*xattr;=0D=0A_=09struct_simple=5Fxattr_*new=5Fxattr_?=
 =?utf-8?q?=3D_NULL;=0D=0A@@_-895,8_+897,12_@@_int_simple=5Fxattr=5Fset(st?=
 =?utf-8?q?ruct_simple=5Fxattrs_*xattrs,_const_char_*name,=0D=0A_=09=09=09?=
 =?utf-8?q?=09err_=3D_-EEXIST;=0D=0A_=09=09=09}_else_if_(new=5Fxattr)_{=0D?=
 =?utf-8?q?=0A_=09=09=09=09list=5Freplace(&xattr->list,_&new=5Fxattr->list?=
 =?utf-8?q?);=0D=0A+=09=09=09=09if_(removed=5Fsize)=0D=0A+=09=09=09=09=09*?=
 =?utf-8?q?removed=5Fsize_=3D_xattr->size;=0D=0A_=09=09=09}_else_{=0D=0A_?=
 =?utf-8?q?=09=09=09=09list=5Fdel(&xattr->list);=0D=0A+=09=09=09=09if_(rem?=
 =?utf-8?q?oved=5Fsize)=0D=0A+=09=09=09=09=09*removed=5Fsize_=3D_xattr->si?=
 =?utf-8?q?ze;=0D=0A_=09=09=09}=0D=0A_=09=09=09goto_out;=0D=0A_=09=09}=0D?=
 =?utf-8?q?=0A@@_-908,6_+914,9_@@_int_simple=5Fxattr=5Fset(struct_simple?=
 =?utf-8?q?=5Fxattrs_*xattrs,_const_char_*name,=0D=0A_=09=09list=5Fadd(&ne?=
 =?utf-8?q?w=5Fxattr->list,_&xattrs->head);=0D=0A_=09=09xattr_=3D_NULL;=0D?=
 =?utf-8?q?=0A_=09}=0D=0A+=0D=0A+=09if_(removed=5Fsize)=0D=0A+=09=09*remov?=
 =?utf-8?q?ed=5Fsize_=3D_-1;=0D=0A_out:=0D=0A_=09spin=5Funlock(&xattrs->lo?=
 =?utf-8?q?ck);=0D=0A_=09if_(xattr)_{=0D=0Adiff_--git_a/include/linux/xatt?=
 =?utf-8?q?r.h_b/include/linux/xattr.h=0D=0Aindex_6dad031be3c2..4cf6e11f4a?=
 =?utf-8?q?3c_100644=0D=0A---_a/include/linux/xattr.h=0D=0A+++_b/include/l?=
 =?utf-8?q?inux/xattr.h=0D=0A@@_-102,7_+102,8_@@_struct_simple=5Fxattr_*si?=
 =?utf-8?q?mple=5Fxattr=5Falloc(const_void_*value,_size=5Ft_size);=0D=0A_i?=
 =?utf-8?q?nt_simple=5Fxattr=5Fget(struct_simple=5Fxattrs_*xattrs,_const_c?=
 =?utf-8?q?har_*name,=0D=0A_=09=09_____void_*buffer,_size=5Ft_size);=0D=0A?=
 =?utf-8?q?_int_simple=5Fxattr=5Fset(struct_simple=5Fxattrs_*xattrs,_const?=
 =?utf-8?q?_char_*name,=0D=0A-=09=09_____const_void_*value,_size=5Ft_size,?=
 =?utf-8?q?_int_flags);=0D=0A+=09=09_____const_void_*value,_size=5Ft_size,?=
 =?utf-8?q?_int_flags,=0D=0A+=09=09_____ssize=5Ft_*removed=5Fsize);=0D=0A_?=
 =?utf-8?q?ssize=5Ft_simple=5Fxattr=5Flist(struct_inode_*inode,_struct_sim?=
 =?utf-8?q?ple=5Fxattrs_*xattrs,_char_*buffer,=0D=0A_=09=09=09__size=5Ft_s?=
 =?utf-8?q?ize);=0D=0A_void_simple=5Fxattr=5Flist=5Fadd(struct_simple=5Fxa?=
 =?utf-8?q?ttrs_*xattrs,=0D=0Adiff_--git_a/mm/shmem.c_b/mm/shmem.c=0D=0Ain?=
 =?utf-8?q?dex_aad3ba74b0e9..f47347cb30f6_100644=0D=0A---_a/mm/shmem.c=0D?=
 =?utf-8?q?=0A+++_b/mm/shmem.c=0D=0A@@_-3243,7_+3243,7_@@_static_int_shmem?=
 =?utf-8?q?=5Fxattr=5Fhandler=5Fset(const_struct_xattr=5Fhandler_*handler,?=
 =?utf-8?q?=0D=0A_=09struct_shmem=5Finode=5Finfo_*info_=3D_SHMEM=5FI(inode?=
 =?utf-8?q?);=0D=0A_=0D=0A_=09name_=3D_xattr=5Ffull=5Fname(handler,_name);?=
 =?utf-8?q?=0D=0A-=09return_simple=5Fxattr=5Fset(&info->xattrs,_name,_valu?=
 =?utf-8?q?e,_size,_flags);=0D=0A+=09return_simple=5Fxattr=5Fset(&info->xa?=
 =?utf-8?q?ttrs,_name,_value,_size,_flags,_NULL);=0D=0A_}=0D=0A_=0D=0A_sta?=
 =?utf-8?q?tic_const_struct_xattr=5Fhandler_shmem=5Fsecurity=5Fxattr=5Fhan?=
 =?utf-8?q?dler_=3D_{=0D=0A--_=0D=0A2.21.1=0D=0A=0D=0A?=
In-Reply-To: <20200305211632.15369-3-dxu@dxuuu.xyz>
Date:   Tue, 10 Mar 2020 11:20:44 -0700
From:   "Daniel Xu" <dxu@dxuuu.xyz>
To:     "Daniel Xu" <dxu@dxuuu.xyz>, <cgroups@vger.kernel.org>,
        <tj@kernel.org>, <lizefan@huawei.com>, <hannes@cmpxchg.org>,
        <viro@zeniv.linux.org.uk>
Cc:     "Daniel Xu" <dxu@dxuuu.xyz>, <shakeelb@google.com>,
        <linux-kernel@vger.kernel.org>, <gregkh@linuxfoundation.org>,
        <kernel-team@fb.com>
Subject: Re: [PATCH v2 2/4] kernfs: Add removed_size out param for
 simple_xattr_set
Message-Id: <C17D34QG2G67.2DUOCLCXQI4RP@dlxu-fedora-R90QNFJV>
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Thu Mar 5, 2020 at 1:16 PM, Daniel Xu wrote:
> This helps set up size accounting in the next commit. Without this out
> param, it's difficult to find out the removed xattr size without taking
> a lock for longer and walking the xattr linked list twice.
>
>=20
> Signed-off-by: Daniel Xu <dxu@dxuuu.xyz>
> ---
> fs/kernfs/inode.c | 2 +-
> fs/xattr.c | 11 ++++++++++-
> include/linux/xattr.h | 3 ++-
> mm/shmem.c | 2 +-
> 4 files changed, 14 insertions(+), 4 deletions(-)
>
>=20
> diff --git a/fs/kernfs/inode.c b/fs/kernfs/inode.c
> index d0f7a5abd9a9..5f10ae95fbfa 100644
> --- a/fs/kernfs/inode.c
> +++ b/fs/kernfs/inode.c
> @@ -303,7 +303,7 @@ int kernfs_xattr_set(struct kernfs_node *kn, const
> char *name,
> if (!attrs)
> return -ENOMEM;
> =20
> - return simple_xattr_set(&attrs->xattrs, name, value, size, flags);
> + return simple_xattr_set(&attrs->xattrs, name, value, size, flags,
> NULL);
> }
> =20
> static int kernfs_vfs_xattr_get(const struct xattr_handler *handler,
> diff --git a/fs/xattr.c b/fs/xattr.c
> index 0d3c9b4d1914..e13265e65871 100644
> --- a/fs/xattr.c
> +++ b/fs/xattr.c
> @@ -860,6 +860,7 @@ int simple_xattr_get(struct simple_xattrs *xattrs,
> const char *name,
> * @value: value of the xattr. If %NULL, will remove the attribute.
> * @size: size of the new xattr
> * @flags: %XATTR_{CREATE|REPLACE}
> + * @removed_size: returns size of the removed xattr, -1 if none removed
> *
> * %XATTR_CREATE is set, the xattr shouldn't exist already; otherwise
> fails
> * with -EEXIST. If %XATTR_REPLACE is set, the xattr should exist;
> @@ -868,7 +869,8 @@ int simple_xattr_get(struct simple_xattrs *xattrs,
> const char *name,
> * Returns 0 on success, -errno on failure.
> */
> int simple_xattr_set(struct simple_xattrs *xattrs, const char *name,
> - const void *value, size_t size, int flags)
> + const void *value, size_t size, int flags,
> + ssize_t *removed_size)
> {
> struct simple_xattr *xattr;
> struct simple_xattr *new_xattr =3D NULL;
> @@ -895,8 +897,12 @@ int simple_xattr_set(struct simple_xattrs *xattrs,
> const char *name,
> err =3D -EEXIST;
> } else if (new_xattr) {
> list_replace(&xattr->list, &new_xattr->list);
> + if (removed_size)
> + *removed_size =3D xattr->size;
> } else {
> list_del(&xattr->list);
> + if (removed_size)
> + *removed_size =3D xattr->size;
> }
> goto out;
> }
> @@ -908,6 +914,9 @@ int simple_xattr_set(struct simple_xattrs *xattrs,
> const char *name,
> list_add(&new_xattr->list, &xattrs->head);
> xattr =3D NULL;
> }
> +
> + if (removed_size)
> + *removed_size =3D -1;
> out:
> spin_unlock(&xattrs->lock);
> if (xattr) {
> diff --git a/include/linux/xattr.h b/include/linux/xattr.h
> index 6dad031be3c2..4cf6e11f4a3c 100644
> --- a/include/linux/xattr.h
> +++ b/include/linux/xattr.h
> @@ -102,7 +102,8 @@ struct simple_xattr *simple_xattr_alloc(const void
> *value, size_t size);
> int simple_xattr_get(struct simple_xattrs *xattrs, const char *name,
> void *buffer, size_t size);
> int simple_xattr_set(struct simple_xattrs *xattrs, const char *name,
> - const void *value, size_t size, int flags);
> + const void *value, size_t size, int flags,
> + ssize_t *removed_size);
> ssize_t simple_xattr_list(struct inode *inode, struct simple_xattrs
> *xattrs, char *buffer,
> size_t size);
> void simple_xattr_list_add(struct simple_xattrs *xattrs,
> diff --git a/mm/shmem.c b/mm/shmem.c
> index aad3ba74b0e9..f47347cb30f6 100644
> --- a/mm/shmem.c
> +++ b/mm/shmem.c
> @@ -3243,7 +3243,7 @@ static int shmem_xattr_handler_set(const struct
> xattr_handler *handler,
> struct shmem_inode_info *info =3D SHMEM_I(inode);
> =20
> name =3D xattr_full_name(handler, name);
> - return simple_xattr_set(&info->xattrs, name, value, size, flags);
> + return simple_xattr_set(&info->xattrs, name, value, size, flags,
> NULL);
> }
> =20
> static const struct xattr_handler shmem_security_xattr_handler =3D {
> --
> 2.21.1
>
>=20

Adding Al Viro, who I forgot to add in the initial send. Will remember
on future sends.

Daniel
