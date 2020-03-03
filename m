Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 360FC178332
	for <lists+cgroups@lfdr.de>; Tue,  3 Mar 2020 20:37:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730073AbgCCThd (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 3 Mar 2020 14:37:33 -0500
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:59887 "EHLO
        out3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728776AbgCCThd (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 3 Mar 2020 14:37:33 -0500
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id 0CE6E21FC6;
        Tue,  3 Mar 2020 14:37:32 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Tue, 03 Mar 2020 14:37:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dxuuu.xyz; h=
        content-transfer-encoding:content-type:in-reply-to:date:to:cc
        :subject:from:message-id; s=fm2; bh=u0IrEIXKCPqF9SikuisdIghTkg0j
        7+8C1skbUGpp0p8=; b=hg/CFqGAMIkShJAKOhOwEMupcwe/MBOezh6zMZhlEclX
        XLJTZigMmqeY4trM0DekrEP28xXqiqiCrjYpVvzqj0gBycW6Ro+kXdwgGNEqp6N9
        TIB6jrPjnfM7wi3EFVjjbAzdR5ktH93gCsn/f7tCmJVlICfhu62flm0AvWKVedAI
        w7x3pg2Bi79SKa3vaDiASVdCvlT7hWkm7seFAq620B7ELVMK+U7DkvLJGommnkq6
        opxhPzkLBgBuHjoeCVqKIpQXbxWJZ660HnkiEpBQYxl6KLkol7mEsLfHz7Oj8k/J
        sef+JBjijk6rFC4xjTSrjs2+/MknHeyyL0imdExfcg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=u0IrEI
        XKCPqF9SikuisdIghTkg0j7+8C1skbUGpp0p8=; b=lW323dlAALeDy5hsb+8RmK
        SGDUenHi6HLukau7SutbXUDiNzQmN+KXAYWgW//+bpSA6n4FvJFQ96pIVV3E9UeE
        6F/gSYi0NKVrZJU/doPWBtIujyTyfwEjDrYO7Xkrkvw8g4acZGapBzM6w7ZQjc3I
        UnXJ0k73TjZRkT0JlgVsMO0kMvpGlEDp6GftHgSeL4Gb1kI5J9dMFDUFfrsIZD1Q
        nKg7xpY2Wloe+lXVEj5tpNgDR0vTblzhA4+c5Jr276wYN5rFEhnkxjVfQzMqh91G
        X4tdUITmVRsS47jbRbzIGL5hNtPujg4ZJg0scPmEpkzKuUvKJgdeDihgp4EjwtKQ
        ==
X-ME-Sender: <xms:-rFeXuWt-RADQjgPJ6QFNpotFT54BM0njm5aIiKyG4h70dqog4a_sQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedugedruddtiedgudeftdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecufghrlhcuvffnffculdejtddmnecujfgurhepgf
    gtjgffvffuhffksehtqhertddttdejnecuhfhrohhmpedfffgrnhhivghlucgiuhdfuceo
    ugiguhesugiguhhuuhdrgiihiieqnecukfhppeduieefrdduudegrddufedvrddunecuve
    hluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepugiguhesugig
    uhhuuhdrgiihii
X-ME-Proxy: <xmx:-rFeXnNsidxuMTbA5XnsHN-ziCzt3xiLvXeVejJdL0lC3H-QCsF83Q>
    <xmx:-rFeXjapRvO8aaAzLF1DEhX8ND8zo7gEpXccfJzkPUSwDhfAVxUPhQ>
    <xmx:-rFeXhTXV7LwaEpssrSa9665B7CgJgZtRTwYN84fxA5uYbRMkNlqoQ>
    <xmx:_LFeXsV0zJh4F0dTBvi9oJxz9hgkTIXx0sgMc9KiwuEHgr_ILIHucg>
Received: from localhost (unknown [163.114.132.1])
        by mail.messagingengine.com (Postfix) with ESMTPA id 66B15328006A;
        Tue,  3 Mar 2020 14:37:29 -0500 (EST)
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Originaldate: Tue Mar 3, 2020 at 11:19 AM
Originalfrom: "Daniel Xu" <dxu@dxuuu.xyz>
Original: =?utf-8?q?On_Tue_Mar_3,_2020_at_8:19_AM,_Tejun_Heo_wrote:
 =0D=0A>_Hello,?= =?utf-8?q?=0D=0A>=0D=0A>_
 =0D=0A>_On_Mon,_Mar_02,_2020_at_05:39:00PM_-0800?=
 =?utf-8?q?,_Daniel_Xu_wrote:=0D=0A>_>_+static_int_kernfs=5Fvfs=5Fuser=5Fx?=
 =?utf-8?q?attr=5Fset(const_struct_xattr=5Fhandler_*handler,=0D=0A>_>_+=09?=
 =?utf-8?q?=09=09=09_____struct_dentry_*unused,_struct_inode_*inode,=0D=0A?=
 =?utf-8?q?>_>_+=09=09=09=09_____const_char_*suffix,_const_void_*value,=0D?=
 =?utf-8?q?=0A>_>_+=09=09=09=09_____size=5Ft_size,_int_flags)=0D=0A>_>_+{?=
 =?utf-8?q?=0D=0A>_...=0D=0A>_>_+=09if_(value_&&_atomic=5Finc=5Freturn(nr)?=
 =?utf-8?q?_>_KERNFS=5FMAX=5FUSER=5FXATTRS)_{=0D=0A>_>_+=09=09ret_=3D_-ENO?=
 =?utf-8?q?SPC;=0D=0A>_>_+=09=09goto_dec=5Fout;=0D=0A>_>_+=09}=0D=0A>=0D?=
 =?utf-8?q?=0A>_=0D=0A>_So,_we_limit_the_number_of_user_xattrs_here_but=0D?=
 =?utf-8?q?=0A>=0D=0A>_=0D=0A>_>_+=09ret_=3D_kernfs=5Fvfs=5Fxattr=5Fset(ha?=
 =?utf-8?q?ndler,_unused,_inode,_suffix,_value,=0D=0A>_>_+=09=09=09=09___s?=
 =?utf-8?q?ize,_flags);=0D=0A>=0D=0A>_=0D=0A>_This_will_call_into_simple?=
 =?utf-8?q?=5Fxattr=5Fset()_which_doesn't_put_any_further=0D=0A>_restricti?=
 =?utf-8?q?on_on_size_and_just_calls_GFP=5FKERNEL_kmalloc_on_it_allowing?=
 =?utf-8?q?=0D=0A>_users_incur_high-order_allocations._Maybe_it'd_make_sen?=
 =?utf-8?q?se_to_limit=0D=0A>_both_the_number_and_size=3F=0D=0A=0D=0AAh_ye?=
 =?utf-8?q?ah_good_point._Will_add.=0D=0A?=
In-Reply-To: <C11FYO0Q9WJU.2MLRRFOQ3E878@dlxu-fedora-R90QNFJV>
Date:   Tue, 03 Mar 2020 11:37:28 -0800
To:     "Daniel Xu" <dxu@dxuuu.xyz>, "Tejun Heo" <tj@kernel.org>
Cc:     <cgroups@vger.kernel.org>, <lizefan@huawei.com>,
        <hannes@cmpxchg.org>, <linux-kernel@vger.kernel.org>,
        <gregkh@linuxfoundation.org>, <kernel-team@fb.com>
Subject: Re: [PATCH 1/2] kernfs: Add option to enable user xattrs
From:   "Daniel Xu" <dxu@dxuuu.xyz>
Message-Id: <C11GC2SN5D18.2S00I3KONE9ZE@dlxu-fedora-R90QNFJV>
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Tue Mar 3, 2020 at 11:19 AM, Daniel Xu wrote:
> On Tue Mar 3, 2020 at 8:19 AM, Tejun Heo wrote:
> > Hello,
> >
> >=20
> > On Mon, Mar 02, 2020 at 05:39:00PM -0800, Daniel Xu wrote:
> > > +static int kernfs_vfs_user_xattr_set(const struct xattr_handler *han=
dler,
> > > +				     struct dentry *unused, struct inode *inode,
> > > +				     const char *suffix, const void *value,
> > > +				     size_t size, int flags)
> > > +{
> > ...
> > > +	if (value && atomic_inc_return(nr) > KERNFS_MAX_USER_XATTRS) {
> > > +		ret =3D -ENOSPC;
> > > +		goto dec_out;
> > > +	}
> >
> >=20
> > So, we limit the number of user xattrs here but
> >
> >=20
> > > +	ret =3D kernfs_vfs_xattr_set(handler, unused, inode, suffix, value,
> > > +				   size, flags);
> >
> >=20
> > This will call into simple_xattr_set() which doesn't put any further
> > restriction on size and just calls GFP_KERNEL kmalloc on it allowing
> > users incur high-order allocations. Maybe it'd make sense to limit
> > both the number and size?
>
>=20
> Ah yeah good point. Will add.
>

It looks like in fs/xattr.c:setxattr, there is already:

    ...
    if (size) {
        if (size > XATTR_SIZE_MAX)
            return -E2BIG;
    ...

where XATTR_SIZE_MAX is defined as 64k. Do you want it even smaller?


Thanks,
Daniel
