Return-Path: <cgroups+bounces-8419-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 74E4EACBF32
	for <lists+cgroups@lfdr.de>; Tue,  3 Jun 2025 06:26:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8FA4B189059D
	for <lists+cgroups@lfdr.de>; Tue,  3 Jun 2025 04:26:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C6771F0E20;
	Tue,  3 Jun 2025 04:26:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EkQkVK12"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90826173
	for <cgroups@vger.kernel.org>; Tue,  3 Jun 2025 04:26:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748924792; cv=none; b=WougtvESUlMNZ+ZE3HfIyXTftj2d9sTTtaHTiWCrnNW/8XIb046IGp2eCcAE/TcEjigBxs71IkZZrCApXt9isyfNLlBEn8nYsvIcq6QwzRwg00ZBSBSesckgXlI2KpqbYKfI2PajCMAneV1FEIO//u7nb5Z0e8zlxhan1oVSThU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748924792; c=relaxed/simple;
	bh=I1j8zTvcyvUTtyIiwV5Apm5t5uhLTsxHzPlYSrorDBc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ldst+FB3BEmZpuzAX7uIt3lfZBJ748dT6FyZa+H9E8E5Rvx1olDD7o1Fxy0lN/LiozaUmP4/8jaihjG5aEiZR0FPVnX2PxG87fjbqhbMUW8dxletHTH0kSV3x2YfRLxoaJqztGoRnQSYGfgAaWfVQZFyLyh18tmcqOQP5MBM8Jg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EkQkVK12; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-747c2cc3419so2620570b3a.2
        for <cgroups@vger.kernel.org>; Mon, 02 Jun 2025 21:26:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748924790; x=1749529590; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=WB2rBVMne7UhSOC0mBGWNKnARAayKz7qfCQKj9Z5fTs=;
        b=EkQkVK12uAg6rsDHLSdf9v45u6C2wg3et7UHpEHjs0b+C2pje32jhazqKYuOiJFqlP
         YnuCDryHwLoE3EZXNx/Y7b/1sF4Ym83Fpx9oJNqRDyCkMe4QAyiIp6acj7IMLANSgzRJ
         Mvs7zgCzHdOzvBa/tYDGTE5b94ufkymi4oj+qc7J80BdqymTyhurGJ+kJ8Loj9iK+R9+
         X3B3im6UJRGIfplGy5gnVXZKXMIg46Vd1WonYuWOMm6apyiREiwH6MCs3oYrJmRX/Vx0
         UFWf9tAjvWQcopT+8Zw8mzCUKkzaGcnOkEgARExiIP+90rPMSkslkjtP9ju4zrhOXtYR
         6qQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748924790; x=1749529590;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WB2rBVMne7UhSOC0mBGWNKnARAayKz7qfCQKj9Z5fTs=;
        b=ERcaq6OHzV2Ny+8twastq3EQCac9qFI0lTgHgvCPgykBwBxMpKwi17MUnCF/58VM3a
         1z68kh5lvjkQbzojwPsYUGWANc0qIlHK6iS9RQQbbQJfaIBXmdJ2oDw2BWE5tqtOHhF1
         pXNLDetYlEBJpFX8PmJJFlVs1fZgQC8TPduQUX1zgsonhZL44U1q/iBLyRevggOaZRtu
         nNWolYVAFBt8NOSFkcOkskArww0mszG5MNpPVdS9BQhN9hX8HZDTSVABnndYr90qJUa6
         TypBGefh4/wzC4ZqQHNbo/nlHV+JK44cyO2m9XyVNPR5OGvJLyBTMuz25o4iV7A5AIRc
         n9xw==
X-Forwarded-Encrypted: i=1; AJvYcCWhgsgu2+coLU6Ygei1xeprb1l2j5s7umbo5lN6tbDZ/AExlkR41cPPf6h3g9HM4S6XzBsPF4+W@vger.kernel.org
X-Gm-Message-State: AOJu0Yy5W7U943ZIiFlSgRxmXsT1Mr9McOiNDyoO3wFns5JblkzUGD6A
	fWPzSve/wZW5/3TKN/kQlyFewDpxVgP+SGu46Rphsar+v8uEZ9yoHwZd
X-Gm-Gg: ASbGncv1wLuCoyiUN7TSva8A4MmhcrzU0k3ar1ElH7jgG2CtMIqT5AGHjC5OJzyw/jy
	SNDsohPGYmIDh924BXZ4807Gtc0x8gbmkwHVzy2jkLdxuGssnnxtoL+Y+2dt3R8MdChZzP0pmxN
	szDQR+ApJjbBeAb7kHiarES++mdbVDKzI8BSwPcTvAvJBb7xujE5s4ZxurktrE6SiEcj9g1Y7tj
	d7Sg+BDMAPt38GTz0FPg6+WYQooxO0GMBRth+PF9+Fk3gGJv2bHssISMdEtJZs206ane+TpgOLB
	+ZH2VjgI8bzpFeBC7ZnDBDyBhvMYHNTkxHKZjufWyEenk9FamxuLiBXsK0fHgOYeFOEF2A6pCXQ
	VTgFXwAQxQhQQK3562Eq829vEr9Ei1Zx2v7g=
X-Google-Smtp-Source: AGHT+IFNkllGxddFA1s/zIPibevNunBp7oymq5HTMfpIN9l2/oViLwZASQKfM7nqN3IfZ8VygaXdIQ==
X-Received: by 2002:a05:6a00:887:b0:747:accb:773c with SMTP id d2e1a72fcca58-747c1bca2b1mr19300133b3a.13.1748924789615;
        Mon, 02 Jun 2025 21:26:29 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:da43:aeff:fecc:bfd5? ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-747afeab0c4sm8454850b3a.48.2025.06.02.21.26.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Jun 2025 21:26:29 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <6aec381e-d548-4b09-ac8b-4b63e1dd1133@roeck-us.net>
Date: Mon, 2 Jun 2025 21:26:27 -0700
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH cgroup/for-6.16] cgroup: avoid per-cpu allocation of size
 zero rstat cpu locks
To: Shakeel Butt <shakeel.butt@linux.dev>
Cc: JP Kobryn <inwardvessel@gmail.com>, tj@kernel.org, klarasmodin@gmail.com,
 yosryahmed@google.com, mkoutny@suse.com, hannes@cmpxchg.org,
 akpm@linux-foundation.org, linux-mm@kvack.org, cgroups@vger.kernel.org,
 kernel-team@meta.com
References: <20250522013202.185523-1-inwardvessel@gmail.com>
 <b9824a99-cca6-43d3-81db-14f4366c5fef@roeck-us.net>
 <CAGj-7pV8-S_b7Bw5uhvdjN-uNRL=gsyyQTMf+36TTzhJXpT3CA@mail.gmail.com>
Content-Language: en-US
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 np3900V20aS7eD9K8GTU0TGC1pyz6IVJwIE=
In-Reply-To: <CAGj-7pV8-S_b7Bw5uhvdjN-uNRL=gsyyQTMf+36TTzhJXpT3CA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 6/2/25 21:10, Shakeel Butt wrote:
> On Mon, Jun 2, 2025 at 8:38 PM Guenter Roeck <linux@roeck-us.net> wrote:
>>
>> On Wed, May 21, 2025 at 06:32:02PM -0700, JP Kobryn wrote:
>>> Subsystem rstat locks are dynamically allocated per-cpu. It was discovered
>>> that a panic can occur during this allocation when the lock size is zero.
>>> This is the case on non-smp systems, since arch_spinlock_t is defined as an
>>> empty struct. Prevent this allocation when !CONFIG_SMP by adding a
>>> pre-processor conditional around the affected block.
>>>
>>
>> It may be defined as empty struct, but it is still dereferenced. This patch
>> is causing crashes on non-SMP systems such as xtensa, m68k, or with x86
>> non-SMP builds.
>>
> 
> Does this still happen with the following patch?
> 
> https://lore.kernel.org/20250528235130.200966-1-inwardvessel@gmail.com/

I guess that should fix it. Sorry, I had not seen/found that patch.

Guenter


