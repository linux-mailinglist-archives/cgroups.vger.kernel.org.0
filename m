Return-Path: <cgroups+bounces-8810-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 30BC4B0CEB9
	for <lists+cgroups@lfdr.de>; Tue, 22 Jul 2025 02:29:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2DDCC1885FA7
	for <lists+cgroups@lfdr.de>; Tue, 22 Jul 2025 00:29:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7FB13A8C1;
	Tue, 22 Jul 2025 00:29:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LsLz5ND2"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3821C323D;
	Tue, 22 Jul 2025 00:29:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753144145; cv=none; b=W7BPF+YiPvmfr+1fDOBi+D5u2oGqR3ScGUKcJrQHG97CUixGuK8csrQPWuWbErbTqA364gAhdc0fKSS03kaznKJkoUDaA3A/lvBMWhaO2Tta8zztCKdfYZh/wJXY0Cra5m/vdAwwGpl02aeVmT7h9rN0tH5p14WfaOoHQ3n45C0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753144145; c=relaxed/simple;
	bh=1oSCdNX7DQYIk3n3ZJ1VeGj/LdIxW93xsqtNV72FQrg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=I8zJlPo1IbOFJo21NBgv0x9Naf0BOwxZH3dTuS/3axS1GBCoFTkCO12N1uAb22P/LDxhQSt9xRLZKWhmBwwXUY4Imz70HSqXxZfuzucKqRiC3OTc35Q4nAdI+VzzhABpQkAF/mJCMayiGafkZK06VbZgo5y/4TWoqARI/0u1HDU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LsLz5ND2; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-23aeac7d77aso41110845ad.3;
        Mon, 21 Jul 2025 17:29:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753144143; x=1753748943; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=oq4jdal9TquQDBj2libt0/0yRkNmtdQsAFlZRWxtTdo=;
        b=LsLz5ND2jMQtkHZK0g/hNw71qQpwa7L9nxm/Qf0pCktCIERgLjLP1wP6o4CT77u5nj
         6po2RAVyVSQEhSrMrckBztjtPaYk1gNEC2/KdznHRs1NGzP/dA9kgpRwjKv4uiWVCxoX
         KVO8LU1sVOdk3Y+LjH1Pqna9+YSFeaEZ3yPG9g7xqp5waKiXeUCimI/lAs702zDCfYPx
         Bf1PiD28p+VijlE9r6R1qgGdhSYw2fSq4CmiVNBVlkV3aHpK4QSD8fJcOSmye4vQsaSj
         dp1wSz0x/ljwcMg24LsLYdnI+ZuO2ba2sM/5/olElB143BI6MHVnJg2kKgIocDzyMBSB
         s7jQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753144143; x=1753748943;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oq4jdal9TquQDBj2libt0/0yRkNmtdQsAFlZRWxtTdo=;
        b=ef/L/Ld+sKFwUPgjFmxDSk3rUv5i/CgSYS4Mxu3N7g34KV0afYOb2+bTvMRd1ZtWLd
         MdqyEBZ7ICBXrjAFHN1zZJrxW6IMVkQquTILxJiTyUAoD34rKpGpUTFnpdd1lC0sUirq
         zEldtNXiw0yguzdIbBhIg+KM3BsBh2Vc8s5QbzsC0OfYxjoDmP8uPEwP1Ngz/r6Yj1uD
         PTPWkzuYAfqhL+B/xzHR5OziMNN8c5BTc4+848nIuVgnQIGmB8gnxQGB4rrKG3dB651g
         +5Q0I/hX3fjx7XsO5gonv221Pjrj0jfGVASCNpcGWSQgSbO4+3Sqda7d+f5Ph+bEmNM9
         zlkQ==
X-Forwarded-Encrypted: i=1; AJvYcCUPQaM/beLBEUZ7pveqJX3YbYDVivDjKP1TBpUfMQ5YnQvXArlPGBrI+I0wJxJIhNDJii8AzFwFuD0DNbaG@vger.kernel.org, AJvYcCWt0KY08m6OIoYUqLkc+UccoO9zFcdeVw0SNYwtklzgy3kNcSUr/xrQCTS31SNlzlPhwj8okXKR@vger.kernel.org
X-Gm-Message-State: AOJu0YwvRjTOFsn2noua8dpf/oIwGb9cTDsn6PlhMWmptNmmWnEuGlZm
	UIw0G5OqtMI2X+ta4Z9eLAm3vyAZoA9YIq+9sibmo/1zuE0Q73bRsooS
X-Gm-Gg: ASbGncs2nc2YnlKbG4dShctsgUAQMJHPPrlPcI3lh45ExcVhmW9HYZfo8O9Cs2mthkX
	TE3kkNoIgPQTPlll0DvNOFOXNU3z7Sd1+9NT8v23BGbw5MrvOUsekxjfn/tzDDU05Xio+Z2O5TQ
	bwEzFAHj42XUJc5317dgug4r0pUtL1aMbpUH8N7CR8AFoRcQ2CmH2DSj75sHzIeJJdcBGL03NP8
	2H9H9NtYX+J/k1jtkNLLIj61yWWXE2+05K3pdiiV+U+Hquv6uofZkez3rboLdMmAKuijN7lbrEA
	efQ9rL/+/7SHbK6CKCl3NtFn+YwUKbVQ/K6+AdFodZAbNARMgtqM08uw1r0yoYqLDHCNBy5ZJYb
	NgBbR6bSKEo74aNrvHOz1LUrue/do9Kg=
X-Google-Smtp-Source: AGHT+IHNF7BKZ99z9zCYMqDZ4VD0vwvR9MiC03EI2F3fyhR2Q0qcVIHpxTmg4IiArxwEH3HbEViX9A==
X-Received: by 2002:a17:902:e804:b0:235:f632:a4d5 with SMTP id d9443c01a7336-23e24f363b1mr274426545ad.9.1753144143405;
        Mon, 21 Jul 2025 17:29:03 -0700 (PDT)
Received: from [192.168.1.117] ([73.222.117.172])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23e3b6d672asm63820045ad.178.2025.07.21.17.29.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Jul 2025 17:29:02 -0700 (PDT)
Message-ID: <e938953c-8735-4276-8f45-543ade5cc515@gmail.com>
Date: Mon, 21 Jul 2025 17:29:01 -0700
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [syzbot] [cgroups?] WARNING in css_rstat_exit
To: Shakeel Butt <shakeel.butt@linux.dev>, =?UTF-8?Q?Michal_Koutn=C3=BD?=
 <mkoutny@suse.com>
Cc: syzbot <syzbot+8d052e8b99e40bc625ed@syzkaller.appspotmail.com>,
 cgroups@vger.kernel.org, hannes@cmpxchg.org, linux-kernel@vger.kernel.org,
 syzkaller-bugs@googlegroups.com, tj@kernel.org
References: <6874b1d8.a70a0220.3b380f.0051.GAE@google.com>
 <2b10ba94-7113-4b27-80bb-fd4ef7508fda@gmail.com>
 <ammabsnegvc5m5qdj3xmydq3vhzw5igiy4fofpzyyzcwz5y7ib@rgbbbvxfxrf3>
 <uenvth6s5pfulsz36nxfgg7s2nfi4wm5334edyogiicq4x54mg@kh7keqfyrihh>
Content-Language: en-US
From: JP Kobryn <inwardvessel@gmail.com>
In-Reply-To: <uenvth6s5pfulsz36nxfgg7s2nfi4wm5334edyogiicq4x54mg@kh7keqfyrihh>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Thanks Michal and Shakeel for the input on this. I will be sending out a
series to harden css_create(). I was able to open a small window for the
placement of css_rstat_init() that satisfies existing constraints and
allows for error handling before refcounts come into play.

On 7/17/25 11:46 AM, Shakeel Butt wrote:
> On Thu, Jul 17, 2025 at 03:28:27PM +0200, Michal Koutný wrote:
>> Thanks for looking into this JP.
>> You seem to tracked down the cause with uncleaned rstat, beware that the
>> approach in the patch would leave reference imbalance after
>> init_and_link_css() though.
> 
> Yeah I discussed the same with JP and I think JP is planning to move the
> css_rstat_init() before init_and_link_css() and a second param to
> css_rstat_init() to differentiate between css_is_self() or not.


