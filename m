Return-Path: <cgroups+bounces-312-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B0727E7971
	for <lists+cgroups@lfdr.de>; Fri, 10 Nov 2023 07:35:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B4BB0B20FBB
	for <lists+cgroups@lfdr.de>; Fri, 10 Nov 2023 06:35:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECD1A1852;
	Fri, 10 Nov 2023 06:35:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="yieh30Rd";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="vQJBwM/4"
X-Original-To: cgroups@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36D1E1C3C;
	Fri, 10 Nov 2023 06:35:09 +0000 (UTC)
Received: from wout5-smtp.messagingengine.com (wout5-smtp.messagingengine.com [64.147.123.21])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9D72769A;
	Thu,  9 Nov 2023 22:35:07 -0800 (PST)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailout.west.internal (Postfix) with ESMTP id 3FCF53200B06;
	Fri, 10 Nov 2023 01:35:05 -0500 (EST)
Received: from imap51 ([10.202.2.101])
  by compute5.internal (MEProxy); Fri, 10 Nov 2023 01:35:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:sender:subject:subject:to:to; s=fm3; t=
	1699598104; x=1699684504; bh=b4ZzDDt0njYwoFJ2ZN/gcE0Je20siJqsd/U
	27wOBtP8=; b=yieh30RdeUYv8s36J2LYyw95FKjfwwzzUE2OyJXZ/AZF2p0/Uub
	Zffu82JE99/otcJpQYmFPAaaklJm05VkqiBA9T7AoLH8U0kRZQ7NwFmNtDlqUbW1
	+wVMsXucgbhWOqOhtGuxUcGRzafHgZqUkc8ARde5cNZs/iHlMWc6thws39NJeK8r
	MBlOIJqeTgWErECYLrO1Xx0hgKVmj8EOiBFjMTi/OcW+tF3ng3c4uA1ascqPXtOg
	tZ7c/aKuG1X0bKEOUkCoXZ8mYDhtZn1XEcLd356LzzNPiVHxq2drZg+o9RKpM4hE
	9C6nHmeae6bAJLgyOqpJXXmKbqJBzbybRRQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:sender:subject:subject:to:to:x-me-proxy
	:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1699598104; x=1699684504; bh=b4ZzDDt0njYwoFJ2ZN/gcE0Je20siJqsd/U
	27wOBtP8=; b=vQJBwM/4Q+kiuhh5q5uiUBn984CL1QnaJYt/iL2VW0/ZrNgv7Dw
	pt3ubFwjPXTzgDNLdhifo3Kl+e7YRhloFDFFBHVOgGPRfat/sKxCy4HdIn2cvyMS
	GcANw8896OG+zqmhoVbMLFv7HLJXpZjdxEeikKeIXaP0glvJDBCZ/QqTFaJJpwg0
	cK4w4oV89294SWZBr1HwOYHatbcbaaEofFIKgRBvBPPRv/mJfcewgFCOfDtKMfLX
	M373LsUdUUR/hw81hlQUuMC1563FfZWLk57lva16tpHdQ49zb0+TGIhi7Jg9Oxcp
	b2NzIk1s1DGyTuFfzSIVev3dyZk71Kyavsg==
X-ME-Sender: <xms:F89NZZOWVmfxXzKrA54GMxWcixUCFA20aB-3rNHV7yVmxPUD9Eu7JQ>
    <xme:F89NZb9KoFy1RHMb1tWn6hG6IlJCxUwFcwgmOfrFaNLDOF4UlUr-O950AJW9gwGXD
    tsYBIPMD627JMrnMqc>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedruddvvddgleegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtgfesthhqredtreerjeenucfhrhhomhepfdet
    rhhnugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrg
    htthgvrhhnpefgkeeuleegieeghfduudeltdekfeffjeeuleehleefudettddtgfevueef
    feeigeenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivg
    eptdenucfrrghrrghmpehmrghilhhfrhhomheprghrnhgusegrrhhnuggsrdguvg
X-ME-Proxy: <xmx:F89NZYTF2_QtmymzjURWMjHCidNomPURzOfAobg3D7_6_dLQ9lNCRA>
    <xmx:F89NZVsdm4c-2Z7K9yUctV8nf4P9Xg8U4wH5bY0ZI8uqMC_5jxBNeQ>
    <xmx:F89NZRcGk09mmJO2SN9RRPnkw43vwqJFQBLo4KvAFMVa6QYOObXudA>
    <xmx:GM9NZTeGNCC2WGrDNMPW-Sw0pb_IzNuhwOc4OZp1BK-ExtWnawmMWw>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id CF212B60089; Fri, 10 Nov 2023 01:35:03 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-1108-g3a29173c6d-fm-20231031.005-g3a29173c
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <98fe8917-9054-4a46-a777-613d8c640d36@app.fastmail.com>
In-Reply-To: 
 <CAADnVQLDOEPmDyipHOH0E6QSg4aJtcHcfghoAQmQtROAMd=imQ@mail.gmail.com>
References: <202311031651.A7crZEur-lkp@intel.com>
 <20231106031802.4188-1-laoar.shao@gmail.com>
 <CAADnVQLDOEPmDyipHOH0E6QSg4aJtcHcfghoAQmQtROAMd=imQ@mail.gmail.com>
Date: Fri, 10 Nov 2023 07:34:43 +0100
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>,
 "Yafang Shao" <laoar.shao@gmail.com>
Cc: "kernel test robot" <lkp@intel.com>,
 "Andrii Nakryiko" <andrii@kernel.org>, "Alexei Starovoitov" <ast@kernel.org>,
 bpf <bpf@vger.kernel.org>,
 "open list:CONTROL GROUP (CGROUP)" <cgroups@vger.kernel.org>,
 "Daniel Borkmann" <daniel@iogearbox.net>,
 "Johannes Weiner" <hannes@cmpxchg.org>, "Hao Luo" <haoluo@google.com>,
 "John Fastabend" <john.fastabend@gmail.com>, "Jiri Olsa" <jolsa@kernel.org>,
 "KP Singh" <kpsingh@kernel.org>, "Zefan Li" <lizefan.x@bytedance.com>,
 "Waiman Long" <longman@redhat.com>,
 "Martin KaFai Lau" <martin.lau@linux.dev>,
 =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>,
 oe-kbuild-all@lists.linux.dev, "kernel test robot" <oliver.sang@intel.com>,
 "Stanislav Fomichev" <sdf@google.com>, "Kui-Feng Lee" <sinquersw@gmail.com>,
 "Song Liu" <song@kernel.org>, "Tejun Heo" <tj@kernel.org>,
 "Yonghong Song" <yonghong.song@linux.dev>,
 "Yosry Ahmed" <yosryahmed@google.com>,
 "Kumar Kartikeya Dwivedi" <memxor@gmail.com>
Subject: Re: [PATCH v2 bpf-next] compiler-gcc: Suppress -Wmissing-prototypes warning
 for all supported GCC
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 9, 2023, at 19:23, Alexei Starovoitov wrote:
> On Sun, Nov 5, 2023 at 7:18=E2=80=AFPM Yafang Shao <laoar.shao@gmail.c=
om> wrote:
>> In the future, if you wish to suppress warnings that are only support=
ed on
>> higher GCC versions, it is advisable to explicitly use "__diag_ignore=
" to
>> specify the GCC version you are targeting.
>>
>> Reported-by: kernel test robot <lkp@intel.com>
>> Closes: https://lore.kernel.org/oe-kbuild-all/202311031651.A7crZEur-l=
kp@intel.com/
>> Suggested-by: Arnd Bergmann <arnd@arndb.de>
>> Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
>> Cc: Kumar Kartikeya Dwivedi <memxor@gmail.com>
>> Cc: Arnd Bergmann <arnd@arndb.de>
>> ---
>>  include/linux/compiler-gcc.h | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/include/linux/compiler-gcc.h b/include/linux/compiler-gc=
c.h
>> index 7af9e34..80918bd 100644
>> --- a/include/linux/compiler-gcc.h
>> +++ b/include/linux/compiler-gcc.h
>> @@ -138,7 +138,7 @@
>>  #endif
>>
>>  #define __diag_ignore_all(option, comment) \
>> -       __diag_GCC(8, ignore, option)
>> +       __diag(__diag_GCC_ignore option)
>
> Arnd,
> does this look good to you?

Yes, this is good. We could do the same thing for=20
clang already, but it doesn't make a huge difference.

Acked-by: Arnd Bergmann <arnd@arndb.de>

