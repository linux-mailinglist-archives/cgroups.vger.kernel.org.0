Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1D6C5178301
	for <lists+cgroups@lfdr.de>; Tue,  3 Mar 2020 20:20:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730364AbgCCTUD (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 3 Mar 2020 14:20:03 -0500
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:40101 "EHLO
        out3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730254AbgCCTUD (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 3 Mar 2020 14:20:03 -0500
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id 740072203C;
        Tue,  3 Mar 2020 14:20:01 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Tue, 03 Mar 2020 14:20:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dxuuu.xyz; h=
        content-transfer-encoding:content-type:in-reply-to:date:cc
        :subject:from:to:message-id; s=fm2; bh=SqCNlbZH8ocvAyttYISsWHKwX
        84caUapAFPB6jsa97s=; b=g6MaKLrIMsUaGb1UjRYqWoDzQokUD1CiYDB2v26mW
        DaLlYLeLS7bZH7ruoRAUXrskg5Y8BaC9PXkjU2hPgmq8izaqMud9Tf7NAMApdcsm
        1DMGlUcfDbgoQ73mk1gXpgpYEYWhDMMHAvAJBxiUJJbqPy/HgFuVAbgTZo5ewc+e
        ZHbIdhNrL5oxK8ZS6wQDnO7h5PKRmE/68zdbtwSERuEPnTXqJ864sZOJCaKDIY9J
        wNDjUp2bwIpEAhvIDOejKoYuc+GGqVAJ/elOHfpr8s01lJs5PWJqRU6wpFkffqBa
        Y74qFJOEjUzr2YHxRJTbx/d1sxGvY88cg/WMYzP3gzlLA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=SqCNlb
        ZH8ocvAyttYISsWHKwX84caUapAFPB6jsa97s=; b=0/MOFvBYBmX+f+lBEXqMky
        oN3rZdVK00aHz/c17ts+U4rsUj52+C9HYF0NvUUndt5SOkFjjdh/GhpwptYNCh5h
        yWgQn+HqrM52+LP4mCbY5uWJmAisbdVEyVSdDifufbXkUoU3xIBBof/638HM7AVq
        XENKYXuvw34Ef9rCRVP1jhTmgJpzOJZZJ7NjU1/1klDWGX2IUjzXf/BNETHDfNes
        83Z5l8wPs8FefxVKPihttZe3qe46c8WJwzuIwO8cdsxvCiMcIAJKJP5w9ScyO8ja
        kQ3QIEEowvN9T6p/8eSjPaevEZ6OXVNmYS+bTyb8HRXyju3/HD7jcqXrMcnHnVDg
        ==
X-ME-Sender: <xms:361eXgvzDBaduEgGtJZuzUWGr3pnEWlEYWSuGWcXsqQkeBA3E9VXMw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedugedruddtiedguddvjecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecufghrlhcuvffnffculdejtddmnecujfgurhepgf
    gtjgffuffhvffksehtqhertddttdejnecuhfhrohhmpedfffgrnhhivghlucgiuhdfuceo
    ugiguhesugiguhhuuhdrgiihiieqnecukfhppeduieefrdduudegrddufedvrddunecuve
    hluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepugiguhesugig
    uhhuuhdrgiihii
X-ME-Proxy: <xmx:361eXj3cbfCJUfl2lq-Hs1kHR4vZN-9y-FjvunoklRNI0bhXDtr5kw>
    <xmx:361eXoC10X1O-5PppsfbLaPFEvnpRig0bvdxvrE2QNMLyvkVtJP1Sg>
    <xmx:361eXhDnyLImTRoHIcdtwNC9O0KTexT5nhxN1b1Y7Z2HJbgqEzSx8Q>
    <xmx:4a1eXp66rKaQte4gMcy3o1stSge8T3sQIU8cWfRKM7KMJndLqMPyiw>
Received: from localhost (unknown [163.114.132.1])
        by mail.messagingengine.com (Postfix) with ESMTPA id 8F1843280063;
        Tue,  3 Mar 2020 14:19:58 -0500 (EST)
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Originaldate: Tue Mar 3, 2020 at 8:19 AM
Originalfrom: "Tejun Heo" <tj@kernel.org>
Original: =?utf-8?q?Hello, =0D=0A=0D=0AOn_Mon,_Mar_02,_2020_at_05:39:00PM_-0800,_Dan?=
 =?utf-8?q?iel_Xu_wrote:=0D=0A>_+static_int_kernfs=5Fvfs=5Fuser=5Fxattr=5F?=
 =?utf-8?q?set(const_struct_xattr=5Fhandler_*handler,=0D=0A>_+=09=09=09=09?=
 =?utf-8?q?_____struct_dentry_*unused,_struct_inode_*inode,=0D=0A>_+=09=09?=
 =?utf-8?q?=09=09_____const_char_*suffix,_const_void_*value,=0D=0A>_+=09?=
 =?utf-8?q?=09=09=09_____size=5Ft_size,_int_flags)=0D=0A>_+{=0D=0A...=0D?=
 =?utf-8?q?=0A>_+=09if_(value_&&_atomic=5Finc=5Freturn(nr)_>_KERNFS=5FMAX?=
 =?utf-8?q?=5FUSER=5FXATTRS)_{=0D=0A>_+=09=09ret_=3D_-ENOSPC;=0D=0A>_+=09?=
 =?utf-8?q?=09goto_dec=5Fout;=0D=0A>_+=09}=0D=0A=0D=0ASo,_we_limit_the_num?=
 =?utf-8?q?ber_of_user_xattrs_here_but=0D=0A=0D=0A>_+=09ret_=3D_kernfs=5Fv?=
 =?utf-8?q?fs=5Fxattr=5Fset(handler,_unused,_inode,_suffix,_value,=0D=0A>_?=
 =?utf-8?q?+=09=09=09=09___size,_flags);=0D=0A=0D=0AThis_will_call_into_si?=
 =?utf-8?q?mple=5Fxattr=5Fset()_which_doesn't_put_any_further=0D=0Arestric?=
 =?utf-8?q?tion_on_size_and_just_calls_GFP=5FKERNEL_kmalloc_on_it_allowing?=
 =?utf-8?q?=0D=0Ausers_incur_high-order_allocations._Maybe_it'd_make_sense?=
 =?utf-8?q?_to_limit=0D=0Aboth_the_number_and_size=3F=0D=0A=0D=0AThanks.?=
 =?utf-8?q?=0D=0A=0D=0A--_=0D=0Atejun=0D=0A?=
In-Reply-To: <20200303131921.GB5186@mtj.thefacebook.com>
Date:   Tue, 03 Mar 2020 11:19:57 -0800
Cc:     <cgroups@vger.kernel.org>, <lizefan@huawei.com>,
        <hannes@cmpxchg.org>, <linux-kernel@vger.kernel.org>,
        <gregkh@linuxfoundation.org>, <kernel-team@fb.com>
Subject: Re: [PATCH 1/2] kernfs: Add option to enable user xattrs
From:   "Daniel Xu" <dxu@dxuuu.xyz>
To:     "Tejun Heo" <tj@kernel.org>
Message-Id: <C11FYO0Q9WJU.2MLRRFOQ3E878@dlxu-fedora-R90QNFJV>
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Tue Mar 3, 2020 at 8:19 AM, Tejun Heo wrote:
> Hello,
>
>=20
> On Mon, Mar 02, 2020 at 05:39:00PM -0800, Daniel Xu wrote:
> > +static int kernfs_vfs_user_xattr_set(const struct xattr_handler *handl=
er,
> > +				     struct dentry *unused, struct inode *inode,
> > +				     const char *suffix, const void *value,
> > +				     size_t size, int flags)
> > +{
> ...
> > +	if (value && atomic_inc_return(nr) > KERNFS_MAX_USER_XATTRS) {
> > +		ret =3D -ENOSPC;
> > +		goto dec_out;
> > +	}
>
>=20
> So, we limit the number of user xattrs here but
>
>=20
> > +	ret =3D kernfs_vfs_xattr_set(handler, unused, inode, suffix, value,
> > +				   size, flags);
>
>=20
> This will call into simple_xattr_set() which doesn't put any further
> restriction on size and just calls GFP_KERNEL kmalloc on it allowing
> users incur high-order allocations. Maybe it'd make sense to limit
> both the number and size?

Ah yeah good point. Will add.
