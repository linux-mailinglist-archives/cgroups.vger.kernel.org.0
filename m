Return-Path: <cgroups+bounces-176-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 787CC7E1373
	for <lists+cgroups@lfdr.de>; Sun,  5 Nov 2023 14:01:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A4C3BB20DCE
	for <lists+cgroups@lfdr.de>; Sun,  5 Nov 2023 13:01:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E375BA5E;
	Sun,  5 Nov 2023 13:01:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="qKKvVS5c";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="gKN0ryHC"
X-Original-To: cgroups@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D786623B3;
	Sun,  5 Nov 2023 13:01:36 +0000 (UTC)
Received: from wout1-smtp.messagingengine.com (wout1-smtp.messagingengine.com [64.147.123.24])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B84FDDE;
	Sun,  5 Nov 2023 05:01:33 -0800 (PST)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailout.west.internal (Postfix) with ESMTP id 818E33200201;
	Sun,  5 Nov 2023 08:01:28 -0500 (EST)
Received: from imap51 ([10.202.2.101])
  by compute5.internal (MEProxy); Sun, 05 Nov 2023 08:01:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:sender:subject:subject:to:to; s=fm3; t=
	1699189288; x=1699275688; bh=KMpj0q3rV4QkSLdC+R+IgEFDCLdM6ALsOeh
	s5fxhziE=; b=qKKvVS5cYktSz7q4FEw3JLvDGpkas6wCYRCtYsSz7++VNip4gec
	SeSmCXAlJKv6k1nBLiIesqRDXB//2opD0udDnpHS9YrJco/iutIrnS0bda9ymFld
	2EEtR7ReaHFiOigKaIsL75yNEShRk4xuxzB99v2R74Jlc3uEE1qA3XWraSNx9JG8
	/TPU/SDfig4Q4AKza591VNPVeiG07VffNAebGm+V0F8nvMYSoqX0xceXwi8aktsO
	9qRq+hjiRj5WFHj5kYYOguVZv9rQgqXjEHxCAOIQVaDPWtckHwNaMWLJ8LS5Aa72
	UeWSYlMVmpmIUY0O2F8Pp4eSWSjR/pgQJ0Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:sender:subject:subject:to:to:x-me-proxy
	:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1699189288; x=1699275688; bh=KMpj0q3rV4QkSLdC+R+IgEFDCLdM6ALsOeh
	s5fxhziE=; b=gKN0ryHCrGDU9pI4Nibqb4KlOnSnqYfdyyh/UoJo92R88Qw9mE5
	VBN/Byx5jjqPelkmoJpKBeqq69usE589v9cYlw0by2QSxlLHvpJ1g++KdONtre9M
	kpW7FPCkSHRSVeOe1qyYTvgV+YMgeZN37JHrxmPRtVPuD2WkccxYCXkqIUN1lHEz
	Ycc9fAo5hRFMOd70WiD3zHnbuHFVmqnQpv/tc2r76I6k/WYeaVA5vjf7d/Vxdi5+
	6a6jLRa3Fw96WTG57d1SCNO0N9BmB1fCwClOGd1K8RfaSD8nTbQoIZxONgIDuii9
	mTgG2Cpj2ohk9cLJwKjG4SirVQkj9mqQoTg==
X-ME-Sender: <xms:JpJHZWZzm02rpCaD9N6VWJnakrZNEK287K8P3xctIQpr-F17-5RmSg>
    <xme:JpJHZZbi29JWLJwhzqFLbhO8LwXJ3oWT4p6PYohzB47T4tH4Y7mK2baz_ZpLtJwSn
    OhW1J1jcWdFAIDlYU4>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrudduvddggeeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtgfesthhqredtreerjeenucfhrhhomhepfdet
    rhhnugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrg
    htthgvrhhnpeegfeejhedvledvffeijeeijeeivddvhfeliedvleevheejleetgedukedt
    gfejveenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    grrhhnugesrghrnhgusgdruggv
X-ME-Proxy: <xmx:JpJHZQ-W2kJpxmOeLwdSxnK24r9stieF8ula6iv0eLwmbdI-fcsIuA>
    <xmx:JpJHZYrKmnYVsRmdd3pAxVhL2-vFOyJYbOlysVf6gL36dJpvCuXuXQ>
    <xmx:JpJHZRr9WzFLJbYqvuuTTdSfc3WOdbiO6mJLDRyZnmQpI310yZjVGQ>
    <xmx:KJJHZaY4vB1r_Wu5W_PvepJU1fwsPoTkWVf0RvCv1MckfCgmINoV0g>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id 245A1B60089; Sun,  5 Nov 2023 08:01:26 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-1108-g3a29173c6d-fm-20231031.005-g3a29173c
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <d178b5b5-4171-4e76-a486-c20d5f081448@app.fastmail.com>
In-Reply-To: 
 <CALOAHbCt4-kDGoW=4R0EarPNV2yNcwy3exkVrn6Tz5Ng8M8gvg@mail.gmail.com>
References: <202311031651.A7crZEur-lkp@intel.com>
 <20231105062227.4190-1-laoar.shao@gmail.com>
 <4f5a8c67-74be-41a1-8a0c-acac40da8902@app.fastmail.com>
 <CALOAHbCt4-kDGoW=4R0EarPNV2yNcwy3exkVrn6Tz5Ng8M8gvg@mail.gmail.com>
Date: Sun, 05 Nov 2023 14:01:04 +0100
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Yafang Shao" <laoar.shao@gmail.com>
Cc: "kernel test robot" <lkp@intel.com>,
 "Andrii Nakryiko" <andrii@kernel.org>, "Alexei Starovoitov" <ast@kernel.org>,
 bpf@vger.kernel.org, cgroups@vger.kernel.org,
 "Daniel Borkmann" <daniel@iogearbox.net>,
 "Johannes Weiner" <hannes@cmpxchg.org>, "Hao Luo" <haoluo@google.com>,
 "John Fastabend" <john.fastabend@gmail.com>, "Jiri Olsa" <jolsa@kernel.org>,
 "KP Singh" <kpsingh@kernel.org>, lizefan.x@bytedance.com,
 "Waiman Long" <longman@redhat.com>,
 "Martin KaFai Lau" <martin.lau@linux.dev>, mkoutny@suse.com,
 oe-kbuild-all@lists.linux.dev, "kernel test robot" <oliver.sang@intel.com>,
 "Stanislav Fomichev" <sdf@google.com>, sinquersw@gmail.com,
 "Song Liu" <song@kernel.org>, "Tejun Heo" <tj@kernel.org>,
 "Yonghong Song" <yonghong.song@linux.dev>, yosryahmed@google.com,
 "Kumar Kartikeya Dwivedi" <memxor@gmail.com>
Subject: Re: [PATCH bpf-next] compiler-gcc: Ignore -Wmissing-prototypes warning for
 older GCC
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Sun, Nov 5, 2023, at 12:54, Yafang Shao wrote:
> On Sun, Nov 5, 2023 at 4:24=E2=80=AFPM Arnd Bergmann <arnd@arndb.de> w=
rote:
>> On Sun, Nov 5, 2023, at 07:22, Yafang Shao wrote:
>> > To address this, we should also suppress the "-Wmissing-prototypes"=
 warning
>> > for older GCC versions. Since "#pragma GCC diagnostic push" is supp=
orted as
>> > of GCC 4.6, it is acceptable to ignore these warnings for GCC >=3D =
5.1.0.
>>
>> Not sure why these need to be suppressed like this at all,
>> can't you just add the prototype somewhere?
>
> BPF kfuncs are intended for use within BPF programs, and they should
> not be called from other parts of the kernel. Consequently, it is not
> appropriate to include their prototypes in a kernel header file.

How does the caller in the BPF program get the prototype?

>> > @@ -131,14 +131,14 @@
>> >  #define __diag_str(s)                __diag_str1(s)
>> >  #define __diag(s)            _Pragma(__diag_str(GCC diagnostic s))
>> >
>> > -#if GCC_VERSION >=3D 80000
>> > -#define __diag_GCC_8(s)              __diag(s)
>> > +#if GCC_VERSION >=3D 50100
>> > +#define __diag_GCC_5(s)              __diag(s)
>> >  #else
>> > -#define __diag_GCC_8(s)
>> > +#define __diag_GCC_5(s)
>> >  #endif
>> >
>>
>> This breaks all uses of __diag_ignore that specify
>> version 8 directly. Just add the macros for each version
>> from 5 to 14 here.
>
> It seems that __diag_GCC_8() or __diag_GCC() are not directly used
> anywhere in the kernel, right?

I see three instances:

drivers/net/ethernet/renesas/sh_eth.c:__diag_ignore(GCC, 8, "-Woverride-=
init",
include/linux/compat.h:     __diag_ignore(GCC, 8, "-Wattribute-alias",  =
                            include/linux/syscalls.h:   __diag_ignore(GC=
C, 8, "-Wattribute-alias",                     =20

The override-init one should probably use version 5 as well,
but I think the -Wattribute-alias ones require GCC 8 and otherwise
cause a warning about an unknown warning option.

__diag_ignore_all() would also be wrong for the override-init
because the option has a different name in clang
(-Winitializer-overrides).

> Therefore it won't break anything if we just replace __diag_GCC_8()
> with __diag_GCC_5().
> It may be cumbersome to add the macrocs for every GCC version if they
> aren't actively used.

For the _all variant, I would prefer to completely remove
the version logic and just use __diag() directly. I think the
entire point of this is that it is used on all supported
versions.

      Arnd

