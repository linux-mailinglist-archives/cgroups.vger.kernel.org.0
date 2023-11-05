Return-Path: <cgroups+bounces-174-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 62C627E1290
	for <lists+cgroups@lfdr.de>; Sun,  5 Nov 2023 09:25:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4BF731C2096B
	for <lists+cgroups@lfdr.de>; Sun,  5 Nov 2023 08:25:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E6B9881F;
	Sun,  5 Nov 2023 08:24:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="OMmGwhhd";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="sHTKbMNp"
X-Original-To: cgroups@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5C368486;
	Sun,  5 Nov 2023 08:24:57 +0000 (UTC)
Received: from wout4-smtp.messagingengine.com (wout4-smtp.messagingengine.com [64.147.123.20])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83D85CF;
	Sun,  5 Nov 2023 01:24:55 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailout.west.internal (Postfix) with ESMTP id 45EA232005B5;
	Sun,  5 Nov 2023 03:24:49 -0500 (EST)
Received: from imap51 ([10.202.2.101])
  by compute5.internal (MEProxy); Sun, 05 Nov 2023 03:24:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:sender
	:subject:subject:to:to; s=fm3; t=1699172688; x=1699259088; bh=or
	9YUNMFjRwUSWluRsX++6MIZS0AqgzAob/FV2CAM50=; b=OMmGwhhdh4cIsq6J8J
	FIcS0g/66QZh5IBrPAYPEcbqXjJ7UURp9sOCV4u3eCYCCHsFVQ/ugMGMy3SBk8PA
	oTBl8g51e0QYlvEmYz3haPDxwqGyFj8Bfqr6lutTHCdJERoTsZahV48Lo7DErKNb
	e37hrSkA0+iuDJE1GTMas/pwrz5VMHEy+BM8L5tt+D9UfABelR2/KUDi+XRo38Cv
	8uid9snVMZKjeCYezEYr/8r2XHUMBMU0VGdijaan5aRPEDHnz9dB37BW5snijPt/
	H+kMk73ZchOLC9n+SwDCQXQgHFr/7FYTWAxkj/XhlmWFhBhVtweBLInat2ZXB3n1
	6vVw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:sender:subject
	:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
	:x-sasl-enc; s=fm3; t=1699172688; x=1699259088; bh=or9YUNMFjRwUS
	WluRsX++6MIZS0AqgzAob/FV2CAM50=; b=sHTKbMNpjpRr7xuZIGuzPnAcW9dqI
	Nuu3xN3mnOKL0EiaxFYXieeirIE0OLPSM9m2W/P9rEF+Y7jzn4XRcNLEaJvW6+sI
	pASG1JBpgVWOaW20ZaCNBAlSuoAEs4uie8JRw7h3ALNx97zn/E805mzbNmr5gWdT
	FyRAyKVHFCtELW40sOmYj9T0KD4Ib9UJRzH+mZCPCH8AAY1K8l6mtpIdAQtlexs+
	MTHPGxA2ZxdCHZ2/VbKHMobfGSXHY5+ALh/EJyyp6Ohy2Fsyfmsz/EQ9OYnDj9tw
	+IuR9oYCuBtWlJ84LWMq+7nIW+6ea52brP59gCwlAlPWnqufgj2lywITQ==
X-ME-Sender: <xms:T1FHZTTYzX3QGA6uakksyTolmHEc4YSRkOdojFAUTR0ABWi-y5fSvQ>
    <xme:T1FHZUziyTAsek5motcCO8KIZZa-oxLNVlmjZcOj7ugVRkeaFJWYjAwSVNInQxD5M
    trpzfVKw00k1V4He0U>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrudduuddguddujecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefofgggkfgjfhffhffvvefutgesthdtredtreertdenucfhrhhomhepfdet
    rhhnugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrg
    htthgvrhhnpeffheeugeetiefhgeethfejgfdtuefggeejleehjeeutefhfeeggefhkedt
    keetffenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    grrhhnugesrghrnhgusgdruggv
X-ME-Proxy: <xmx:UFFHZY36taROz2xQgtJNXjrBPgjY1Yep1IP7YYEBJzvidu0HQ6jpCg>
    <xmx:UFFHZTDIdSWVFbonWI_3-rc7NiaMTOCBMfAt9e_sXXPG2AYN4HKQ1Q>
    <xmx:UFFHZcgghS1N8A32zQXd3jXVS6RIf5mHMXhr5g4WDcfJtByr8MICgQ>
    <xmx:UFFHZXQctzXSHepqghTZWaBWcT1Mi5eohYWb1u_IX0iYT2mDZqU1pg>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id D6637B60089; Sun,  5 Nov 2023 03:24:47 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-1108-g3a29173c6d-fm-20231031.005-g3a29173c
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <4f5a8c67-74be-41a1-8a0c-acac40da8902@app.fastmail.com>
In-Reply-To: <20231105062227.4190-1-laoar.shao@gmail.com>
References: <202311031651.A7crZEur-lkp@intel.com>
 <20231105062227.4190-1-laoar.shao@gmail.com>
Date: Sun, 05 Nov 2023 09:24:26 +0100
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Yafang Shao" <laoar.shao@gmail.com>, "kernel test robot" <lkp@intel.com>
Cc: "Andrii Nakryiko" <andrii@kernel.org>,
 "Alexei Starovoitov" <ast@kernel.org>, bpf@vger.kernel.org,
 cgroups@vger.kernel.org, "Daniel Borkmann" <daniel@iogearbox.net>,
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
Content-Type: text/plain

On Sun, Nov 5, 2023, at 07:22, Yafang Shao wrote:
> The kernel supports a minimum GCC version of 5.1.0 for building. However,
> the "__diag_ignore_all" directive only suppresses the
> "-Wmissing-prototypes" warning for GCC versions >= 8.0.0. As a result, when
> building the kernel with older GCC versions, warnings may be triggered. The
> example below illustrates the warnings reported by the kernel test robot
> using GCC 7.5.0:
>
>   compiler: gcc-7 (Ubuntu 7.5.0-6ubuntu2) 7.5.0
>   All warnings (new ones prefixed by >>):
>
>    kernel/bpf/helpers.c:1893:19: warning: no previous prototype for 
> 'bpf_obj_new_impl' [-Wmissing-prototypes]
>     __bpf_kfunc void *bpf_obj_new_impl(u64 local_type_id__k, void 
> *meta__ign)
>                       ^~~~~~~~~~~~~~~~
>    kernel/bpf/helpers.c:1907:19: warning: no previous prototype for 
> 'bpf_percpu_obj_new_impl' [-Wmissing-prototypes]
>     __bpf_kfunc void *bpf_percpu_obj_new_impl(u64 local_type_id__k, 
> void *meta__ign)
>    [...]
>
> To address this, we should also suppress the "-Wmissing-prototypes" warning
> for older GCC versions. Since "#pragma GCC diagnostic push" is supported as
> of GCC 4.6, it is acceptable to ignore these warnings for GCC >= 5.1.0.

Not sure why these need to be suppressed like this at all,
can't you just add the prototype somewhere?

> @@ -131,14 +131,14 @@
>  #define __diag_str(s)		__diag_str1(s)
>  #define __diag(s)		_Pragma(__diag_str(GCC diagnostic s))
> 
> -#if GCC_VERSION >= 80000
> -#define __diag_GCC_8(s)		__diag(s)
> +#if GCC_VERSION >= 50100
> +#define __diag_GCC_5(s)		__diag(s)
>  #else
> -#define __diag_GCC_8(s)
> +#define __diag_GCC_5(s)
>  #endif
> 

This breaks all uses of __diag_ignore that specify
version 8 directly. Just add the macros for each version
from 5 to 14 here.

     Arnd

