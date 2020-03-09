Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D375A17E6E5
	for <lists+cgroups@lfdr.de>; Mon,  9 Mar 2020 19:22:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726661AbgCISVh (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 9 Mar 2020 14:21:37 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:40231 "EHLO
        out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727323AbgCISVh (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 9 Mar 2020 14:21:37 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.nyi.internal (Postfix) with ESMTP id 1336E21B6B;
        Mon,  9 Mar 2020 14:21:36 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Mon, 09 Mar 2020 14:21:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dxuuu.xyz; h=
        content-transfer-encoding:content-type:in-reply-to:date:cc
        :subject:from:to:message-id; s=fm2; bh=Dj8K1Y9A/sg8En4uAWfo+rhEO
        VoMBMW9TFciIFvXrkE=; b=bZuCeSSWq8fdUjsWIYiXViPPtFUijVzJJqyfWz8RD
        j2/DY/zLoVyKzJoIBj9Nx6EcdQY9qnVeWyQXPurcNir6/dV6HhcXESlOKquWL+oV
        fkrlFouUR5dexW/dFMzJRxEh2jN7kSqIBSC2evA0hlKfWn7YGJ4jmsvjmMkd0eOg
        JMixXV0tw6bKBLwQxAEsq3JpxdniJBeIYQkKIYwnpsiECzKbhqp3x3tppviJv/F7
        2VBbikfuB/obg++ywvEAf/6g9dRpn7wvdKaUf5d+zdJTTSH2JwLACpVEo+tb/Pru
        NywFXqw9X6DXUNRAqnATJWqa4HkvxYbuV/nKjPrABWy5g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=Dj8K1Y
        9A/sg8En4uAWfo+rhEOVoMBMW9TFciIFvXrkE=; b=22A3LS72KSpNWbka0RGeLW
        vfHJrUbDsKroCmTxe1wyBSoPYA+NgvED+pCnW6ue8y1/9huYTCxp7p6fNrGFUOr4
        yd9OdRI7Jo66M4EChIlDKrsg9nDBhVwtk2UDVB7I7R/EdwUB7JILB2qXxhJrfDgE
        WMBEEXQLzwxrqgLTMHjyUAmaHUUKZxRKTDzz6BaWvF09eOeYoQKRKKwiGyW9bQXD
        QC4KZcV8Culz97nevi5ZHVAlNQeFs0y2xDXni87lVuH2cwyCi99gvXR8OWUl6Knm
        HAEQwVEl4RDt0oyHC0/bjYA6HA5EgkzLOv/64evH9vfX4UWRiiKJRcvBiGoTN9lA
        ==
X-ME-Sender: <xms:L4lmXrvXVdEmqXlyQLgMcCYhhHG6U9i5iu9N4EKgFDI4icsK3poaDQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedugedruddukedgudduvdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecufghrlhcuvffnffculdejtddmnecujfgurhepgf
    gtjgffuffhvffksehtqhertddttdejnecuhfhrohhmpedfffgrnhhivghlucgiuhdfuceo
    ugiguhesugiguhhuuhdrgiihiieqnecukfhppeduieefrdduudegrddufedvrdegnecuve
    hluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepugiguhesugig
    uhhuuhdrgiihii
X-ME-Proxy: <xmx:L4lmXlrmc5u4avNOqwDM1yp0UvNNKZMv-aP3rNqFePmT-aueyP51vA>
    <xmx:L4lmXo7R87Uj2tueGW9Hs6RhR--EJRjNECTG0cTRBVWqLU5qre2xSw>
    <xmx:L4lmXrEgIRcFXK6XPZvE8RJKcaAZ3UweuHkAmpyHvTkL7_IKV9QkNQ>
    <xmx:MIlmXv879FWIgXqfvjqSfDKDF_m9o0IjyvOfX5nFFgZKY8Mcx67Njg>
Received: from localhost (unknown [163.114.132.4])
        by mail.messagingengine.com (Postfix) with ESMTPA id E6F153280065;
        Mon,  9 Mar 2020 14:21:33 -0400 (EDT)
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Originalfrom: "Joe Perches" <joe@perches.com>
Original: =?utf-8?q?On_Thu,_2020-03-05_at_13:16_-0800,_Daniel_Xu_wrote:
 =0D=0A>_It's?= =?utf-8?q?_not_really_necessary_to_have_contiguous_physical_memory_for_xa?=
 =?utf-8?q?ttr=0D=0A>_values._We_no_longer_need_to_worry_about_higher_orde?=
 =?utf-8?q?r_allocations=0D=0A>_failing_with_kvmalloc,_especially_because_?=
 =?utf-8?q?the_xattr_size_limit_is_at=0D=0A>_64K.=0D=0A=0D=0ASo_why_use_vm?=
 =?utf-8?q?alloc_memory_at_all=3F=0D=0A=0D=0A>_diff_--git_a/fs/xattr.c_b/f?=
 =?utf-8?q?s/xattr.c=0D=0A']=0D=0A>_@@_-817,7_+817,7_@@_struct_simple=5Fxa?=
 =?utf-8?q?ttr_*simple=5Fxattr=5Falloc(const_void_*value,_size=5Ft_size)?=
 =?utf-8?q?=0D=0A>__=09if_(len_<_sizeof(*new=5Fxattr))=0D=0A>__=09=09retur?=
 =?utf-8?q?n_NULL;=0D=0A>__=0D=0A>_-=09new=5Fxattr_=3D_kmalloc(len,_GFP=5F?=
 =?utf-8?q?KERNEL);=0D=0A>_+=09new=5Fxattr_=3D_kvmalloc(len,_GFP=5FKERNEL)?=
 =?utf-8?q?;=0D=0A=0D=0AWhy_is_this_sensible=3F=0D=0Avmalloc_memory_is_a_m?=
 =?utf-8?q?uch_more_limited_resource.=0D=0A=0D=0AAlso,_it_seems_as_if_the_?=
 =?utf-8?q?function_should_set=0D=0Anew=5Fxattr->name_to_NULL_before_the_r?=
 =?utf-8?q?eturn.=0D=0A=0D=0A=0D=0A?=
In-Reply-To: <58c6e6dafabea52e5b030d18b83c13e4f43ab8e3.camel@perches.com>
Originaldate: Fri Mar 6, 2020 at 12:49 AM
Date:   Mon, 09 Mar 2020 11:21:33 -0700
Cc:     <shakeelb@google.com>, <linux-kernel@vger.kernel.org>,
        <gregkh@linuxfoundation.org>, <kernel-team@fb.com>
Subject: Re: [PATCH v2 1/4] kernfs: kvmalloc xattr value instead of kmalloc
From:   "Daniel Xu" <dxu@dxuuu.xyz>
To:     "Joe Perches" <joe@perches.com>, <cgroups@vger.kernel.org>,
        <tj@kernel.org>, <lizefan@huawei.com>, <hannes@cmpxchg.org>
Message-Id: <C16IH7NEXW4J.440OGTNY7CWX@dlxu-fedora-R90QNFJV>
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Hi Joe,

On Fri Mar 6, 2020 at 12:49 AM, Joe Perches wrote:
> On Thu, 2020-03-05 at 13:16 -0800, Daniel Xu wrote:
> > It's not really necessary to have contiguous physical memory for xattr
> > values. We no longer need to worry about higher order allocations
> > failing with kvmalloc, especially because the xattr size limit is at
> > 64K.
>
>=20
> So why use vmalloc memory at all?
>
>=20
> > diff --git a/fs/xattr.c b/fs/xattr.c
> ']
> > @@ -817,7 +817,7 @@ struct simple_xattr *simple_xattr_alloc(const void =
*value, size_t size)
> >  	if (len < sizeof(*new_xattr))
> >  		return NULL;
> > =20
> > -	new_xattr =3D kmalloc(len, GFP_KERNEL);
> > +	new_xattr =3D kvmalloc(len, GFP_KERNEL);
>
>=20
> Why is this sensible?
> vmalloc memory is a much more limited resource.

What would be the alternative? As Greg said, contiguous memory should be
more scarce.

> Also, it seems as if the function should set
> new_xattr->name to NULL before the return.
>

Will add and send in a different patch.


Thanks,
Daniel
