Return-Path: <cgroups+bounces-4814-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E4687973C67
	for <lists+cgroups@lfdr.de>; Tue, 10 Sep 2024 17:40:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 777651F2342E
	for <lists+cgroups@lfdr.de>; Tue, 10 Sep 2024 15:40:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E6B319EEA1;
	Tue, 10 Sep 2024 15:39:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="tVd7kvc+"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-io1-f44.google.com (mail-io1-f44.google.com [209.85.166.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9777D19DFAE
	for <cgroups@vger.kernel.org>; Tue, 10 Sep 2024 15:39:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725982792; cv=none; b=T04b4UEG6ScOvsSN7bA3U12bdFk9f6YAwcSX+rUpFrY5wtj6exXsoIx/kjP9LeyGXUn7K/tYvQ/yBujfodolC7epni+6VaUyVnaj2p7TNtlkCymK7Cltbul58i6DeUgt8Yt6+oCBoxfaDs05EEfiEy4zvYHSUukh01LktWI3EQk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725982792; c=relaxed/simple;
	bh=JFQUDpIIqVGC+KcZvekTCjrJJGjorVEXq0PYnEzZEpo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=m+ODL8oOrHpX1sxrPuWECVzb1ZiaXiMWU4PFJnpKR3LrINreWWRrwBL+fYu9R7p0NxodiAObidy6L9MPjcvTB+s3FosYo/yiY+eCgHIbl7Q1l2lpvsdrWTNYa2Xbc98UgVkKdgig/nUFAZ2Ycwr434DnZUt6V2zv1ZUbB4t3u88=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=tVd7kvc+; arc=none smtp.client-ip=209.85.166.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-io1-f44.google.com with SMTP id ca18e2360f4ac-829f7911eecso340007239f.1
        for <cgroups@vger.kernel.org>; Tue, 10 Sep 2024 08:39:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1725982788; x=1726587588; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=r7S9jkmcKX8edxDXme+IR3XW6CkbAWnQ9A9SSFtVPTU=;
        b=tVd7kvc+QaD+oJO7O1faC9N6NAwrzWOnEfYyXRei0Xj4CB+rPJ7ggQOD9XeXEKPeQL
         itwkby/HrDDHOBCg6P/Lb94OT3DWkqqysLBEplpVdzMZ+8o4uRe0wW/49NEf2OS+qSBA
         176p0Fm1DiJDLX7PMou8SMJrTmUR0lRd9T6OqVauOztn5LgCsaH5cgptGzkkiKsmNLWv
         jXTFSC6g8/OXT7bbmAoKuQNrCSKqis1mNb1E8pVt6TiMMvO7SWY8Q7VMpobFM5b34904
         kyQLMfSiJucrGGxjrHIv2b5J7sP7p1lBvuyLfTIxjPtjioWK1U5PYOW9wYM9Q40HKBXA
         CRMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725982788; x=1726587588;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=r7S9jkmcKX8edxDXme+IR3XW6CkbAWnQ9A9SSFtVPTU=;
        b=tkNIAzX7eI6/4ZvqZvDhGjZbj6dISHfRGNzhS9ggSo+kcUFzBDhYq0SbWQvPF15xqb
         QKyo8u9RwqOExgMBTkzNXtayGCe3p8VWW0O8ysjVsaCE2XjqxYFL+kZPL+niT3vyCCim
         NCTG77S0YfABUdc3PGNVutRbMr/PwYvjEEKnSjgwLHq8p9yjCqnwMJcEWc1NEIKqKQGJ
         Mdt3i5p0Z8jfIx7xqfNEITfIoDoUMxDLVHe6gCAaiGDfp69asoFyK9ofMhdaZTebKtGp
         0pvi1tcXeqKQzM9V1zUF+9cvDYAsq5uhRdRrnxOvJMTAaq94WDQ9L5PHeHcBX1gW0FXF
         RuMw==
X-Forwarded-Encrypted: i=1; AJvYcCXtFpPJmG32RG92jCaXBGgcYW0iyuCDpzIEljwg0+Ecu0xxnSgAEDC+OjTcChE+AUc/capmhyiE@vger.kernel.org
X-Gm-Message-State: AOJu0YzVhiAuxuEJjH70Sl0m4K1z2qbyJrOPInrIJNNgEHQRoeu4mIgS
	+G+GQZpQIM/a0fGOD0EK1xSF61Q2gM8WblB3MPdYeIH0wFxHIG2rRd/JcHu8hoo=
X-Google-Smtp-Source: AGHT+IFVmYj5/4J2t13Vg0qO60pPXoJD02ep9zLYKi3Eh46a/fs6iDD+T2Xugo09KGeX1+cAU3Lacg==
X-Received: by 2002:a05:6602:6d09:b0:82a:a693:2736 with SMTP id ca18e2360f4ac-82aa6932a67mr1209472839f.9.1725982787707;
        Tue, 10 Sep 2024 08:39:47 -0700 (PDT)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4d094560ea5sm1689742173.58.2024.09.10.08.39.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Sep 2024 08:39:47 -0700 (PDT)
Message-ID: <b1722df1-82ff-4d95-93f1-b41cfa829cac@kernel.dk>
Date: Tue, 10 Sep 2024 09:39:46 -0600
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] io_uring/io-wq: respect cgroup cpusets
To: "MOESSBAUER, Felix" <felix.moessbauer@siemens.com>
Cc: "io-uring@vger.kernel.org" <io-uring@vger.kernel.org>,
 "cgroups@vger.kernel.org" <cgroups@vger.kernel.org>,
 "Bezdeka, Florian" <florian.bezdeka@siemens.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "longman@redhat.com" <longman@redhat.com>,
 "asml.silence@gmail.com" <asml.silence@gmail.com>,
 "dqminh@cloudflare.com" <dqminh@cloudflare.com>,
 "Schmidt, Adriaan" <adriaan.schmidt@siemens.com>
References: <20240910143320.123234-1-felix.moessbauer@siemens.com>
 <ec01745a-b102-4f6e-abc9-abd636d36319@kernel.dk>
 <92d7b08e4b077530317a62bb49bc2888413b244a.camel@siemens.com>
 <9cd8bae3-ba32-4b44-a4c0-63f5e5a3de35@kernel.dk>
 <e7b15755c350f6d9ae719065a7fc20f940d314b3.camel@siemens.com>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <e7b15755c350f6d9ae719065a7fc20f940d314b3.camel@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/10/24 9:37 AM, MOESSBAUER, Felix wrote:
> On Tue, 2024-09-10 at 09:17 -0600, Jens Axboe wrote:
>> On 9/10/24 9:08 AM, MOESSBAUER, Felix wrote:
>>> On Tue, 2024-09-10 at 08:53 -0600, Jens Axboe wrote:
>>>> On 9/10/24 8:33 AM, Felix Moessbauer wrote:
>>>>> Hi,
>>>>>
>>>>> this series continues the affinity cleanup work started in
>>>>> io_uring/sqpoll. It has been tested against the liburing
>>>>> testsuite
>>>>> (make runtests), whereby the read-mshot test always fails:
>>>>>
>>>>>   Running test read-mshot.t
>>>>>   Buffer ring register failed -22
>>>>>   test_inc 0 0
>>>>> failed                                                         
>>>>>     
>>>>>                                                              
>>>>>   Test read-mshot.t failed with ret 1     
>>>>>
>>>>> However, this test also fails on a non-patched linux-next @ 
>>>>> bc83b4d1f086.
>>>>
>>>> That sounds very odd... What liburing are you using? On old
>>>> kernels
>>>> where provided buffer rings aren't available the test should just
>>>> skip,
>>>> new ones it should pass. Only thing I can think of is that your
>>>> liburing
>>>> repo isn't current?
>>>
>>> Hmm... I tested against
>>> https://github.com/axboe/liburing/commit/74fefa1b51ee35a2014ca6e7667d7c10e9c5b06f
>>
>> That should certainly be fine.
>>
>>> I'll redo the test against the unpatched kernel to be 100% sure
>>> that it
>>> is not related to my patches. The -22 is likely an -EINVAL.
>>
>> I'd be highly surprised if it's related to your patches! Here's what
>> I
>> get on the current kernel:
>>
>> axboe@m2max-kvm ~/g/liburing (master)> test/read-mshot.t
>> axboe@m2max-kvm ~/g/liburing (master)> echo $status
> 
> Without your patches for liburing, this test definitely fails on linux-
> next @ bc83b4d1f086 (in qemu). Same error as above. Some more
> information:
> $ uname -a
> Linux test-iou 6.11.0-rc7 #1 SMP PREEMPT_DYNAMIC Thu, 01 Jan 1970
> 01:00:00 +0000 x86_64 GNU/Linux
> 
> Strange...

It could just be that I never tested that version on a kernel that has
support for ring provided buffers, but not for incrementally consumed
ones. Though that should be in -next for a while now, so even that
doesn't make sense... Oh well, should work now.

> By that, I assume my patches themselves are fine. I'll just update the
> commit messages to fix the oddities and send a functionally identical
> v2.

Sounds good, thanks.

-- 
Jens Axboe

