Return-Path: <cgroups+bounces-10402-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5084BB97275
	for <lists+cgroups@lfdr.de>; Tue, 23 Sep 2025 20:03:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 46661189462F
	for <lists+cgroups@lfdr.de>; Tue, 23 Sep 2025 18:03:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C3682F6198;
	Tue, 23 Sep 2025 18:02:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TJ/H37Rw"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 838FF2D9EF0
	for <cgroups@vger.kernel.org>; Tue, 23 Sep 2025 18:02:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758650573; cv=none; b=FRvEzkGHmM6G67S1zTWbjth1pg/Jh+WEhKHx97WOiUdcW3paLPZfbYcAqSnEKsn3r2DZPt+0egbhbvjOKNt0MdOtzNnDFpjeqTih3YuLQudf6aj2sJExmJ4Nz2HMSqEp81yD7naRB663q0EM3AKf/ZScWUrc03VGa2TnANbcOKo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758650573; c=relaxed/simple;
	bh=cwxWA5SjpJsmIGAEtf/ZI6lsWcCkGm6hw9JIin8TAEM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZsF4U+/ecJPon51cVRk1tp22TlopotC+A4fMbx23hnOi1TED01bc4QbyGe/xbILTts03fESxtFUP8U9ncpmjoFqGCnzhBo3A22RnueF9h2Q2DEilTIDoZG3EtRlPeTCFUVzolYmsG8FYpoy4uieJRPQ6CRDoJ5Udda09W4lz5v4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TJ/H37Rw; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-b55115148b4so3824714a12.3
        for <cgroups@vger.kernel.org>; Tue, 23 Sep 2025 11:02:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758650571; x=1759255371; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=i+tqvwE+E0cZ1fEaxr5t2bL8HNbMuR4y65gYrn4JYKo=;
        b=TJ/H37Rwjis6xDKTLdb06zEkg2wcvcRHJoq3/PEC1N98x+GsmG5N0K4KXFy1UTodCF
         mbVBafJ2DKGW+2aU7RCJirQeAEAuMqsOSIMPQQCt8/zV+eCSKSWh+QF4FvufuWwfvYkE
         7BD5f5WhGFylaQSDf26RHT2XkBs0MdNJNE5EOoVC3iAyHlvsMAWMhrbKCpRfo4nR2u8w
         JF210h4L8E+4ualBxHS9RadE3Lhi4XE6s8cQ7S8SsVSpxKPUEZ1aSjGJRZRYMqiR5tyF
         5kcr7cmyI8LyDCFKvLUbdkCFl4EVV/rwvcS9HQAVR/2CofrZvaEE16wBgD3Wi/v+sTVJ
         Tqhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758650571; x=1759255371;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=i+tqvwE+E0cZ1fEaxr5t2bL8HNbMuR4y65gYrn4JYKo=;
        b=eVEt/zsDSxPOumxA252jOVLp5JrlQBB8xvSQuk04ZoR+fy8vSqJO4E/ZKAmfwsFISA
         zG+HiWbE2g3TD7eBEJqnm8FNoGXhrmvpvTXSDuKV8b+38hi/ujPayDQPmDpEFdr+QUPm
         QF1QvR+IhEYPmKGdrIWNbf9CGaKNTRDBb5gcbfiwZFind6siY97rG8588mgy8FjT0oPK
         vJMml06KmFXQ0hWGN12lzLAxR0MJs3uuQz8hXrnpLHsprxHKAQm5GRO+38qCDSUblnG3
         j1HCu1zps8fQwm2KJFoEIo9JdpYx0df+9WCxpA3l0wjhHW5khzbFPrtIuEDOvfNcEN5v
         Q/4g==
X-Forwarded-Encrypted: i=1; AJvYcCVRN4DmrzmRZjLz7YIJIS53pWYxOtdCUeNXHcIZb0fb5Gu1iDI1LKe8T7iXVtzvKZmZj0RAL6m0@vger.kernel.org
X-Gm-Message-State: AOJu0YxNz3adxFqjcO6B2H+wK8wlwmrmND1i99k9zLlvayHeo+WG+sa1
	TgD5o8KnyZEWQ7rgaGy5p22L+bVuX54CZqNXRMybEWcGQ6m6EkRh3LEd
X-Gm-Gg: ASbGncsO5Fsb2k1yj4r9nIoCP++9Imb/cVyo1xHK2IzshI4ZGz7MYIpLni7+iW4WXDU
	YIqXoAMmq70+GI9yHKN49BM8mU8p3byvJtMYIGvbMRQeFnj/u0/kflhfCMmRee42HSNC0hJIutJ
	UuiTCitqBDn+92oQUvBYwZ+zhZSI5yehjUJNyF4qpfblG8UYlvwMKKB0oEnwCK/mK0T/UoxDXNH
	G0PgSVQiJkoczfSKoyV0PTBlYfB4fuLmKXdk/waJKZFTd2tHqBRAVJBvz/KttgRbuNBWdKSGQNK
	yCeebQ0svcnIyfeeDof234aT+jamOJjEWwCvOmR1+vfsrTdGA5c4u/SXHD/YgPU6+IapG9UPBAC
	prfTwVVrq2vMId9HU+psiLGgCJ8nkyAfT
X-Google-Smtp-Source: AGHT+IFUlOckCHI+KwnlDW4tzUdg15UTb2EGkiOLw73qogkO+0zulqJJ9EPdzpVIEp7UN6ZvkshONw==
X-Received: by 2002:a17:903:37d0:b0:25f:9682:74ae with SMTP id d9443c01a7336-27cc5a09d62mr39648005ad.29.1758650570586;
        Tue, 23 Sep 2025 11:02:50 -0700 (PDT)
Received: from [192.168.4.196] ([73.222.117.172])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-269800541adsm168967475ad.4.2025.09.23.11.02.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Sep 2025 11:02:49 -0700 (PDT)
Message-ID: <01fdd968-8b82-4777-88c3-e1dc0c81e9bc@gmail.com>
Date: Tue, 23 Sep 2025 11:02:48 -0700
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH] memcg: introduce kfuncs for fetching memcg stats
To: Shakeel Butt <shakeel.butt@linux.dev>
Cc: mkoutny@suse.com, yosryahmed@google.com, hannes@cmpxchg.org,
 tj@kernel.org, akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
 cgroups@vger.kernel.org, kernel-team@meta.com, linux-mm@kvack.org,
 bpf@vger.kernel.org
References: <20250920015526.246554-1-inwardvessel@gmail.com>
 <ky2yjg6qrqf6hqych7v3usphpcgpcemsmfrb5ephc7bdzxo57b@6cxnzxap3bsc>
Content-Language: en-US
From: JP Kobryn <inwardvessel@gmail.com>
In-Reply-To: <ky2yjg6qrqf6hqych7v3usphpcgpcemsmfrb5ephc7bdzxo57b@6cxnzxap3bsc>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/19/25 10:17 PM, Shakeel Butt wrote:
> +linux-mm, bpf
> 
> Hi JP,
> 
> On Fri, Sep 19, 2025 at 06:55:26PM -0700, JP Kobryn wrote:
>> The kernel has to perform a significant amount of the work when a user mode
>> program reads the memory.stat file of a cgroup. Aside from flushing stats,
>> there is overhead in the string formatting that is done for each stat. Some
>> perf data is shown below from a program that reads memory.stat 1M times:
>>
>> 26.75%  a.out [kernel.kallsyms] [k] vsnprintf
>> 19.88%  a.out [kernel.kallsyms] [k] format_decode
>> 12.11%  a.out [kernel.kallsyms] [k] number
>> 11.72%  a.out [kernel.kallsyms] [k] string
>>   8.46%  a.out [kernel.kallsyms] [k] strlen
>>   4.22%  a.out [kernel.kallsyms] [k] seq_buf_printf
>>   2.79%  a.out [kernel.kallsyms] [k] memory_stat_format
>>   1.49%  a.out [kernel.kallsyms] [k] put_dec_trunc8
>>   1.45%  a.out [kernel.kallsyms] [k] widen_string
>>   1.01%  a.out [kernel.kallsyms] [k] memcpy_orig
>>
>> As an alternative to reading memory.stat, introduce new kfuncs to allow
>> fetching specific memcg stats from within bpf iter/cgroup-based programs.
>> Reading stats in this manner avoids the overhead of the string formatting
>> shown above.
>>
>> Signed-off-by: JP Kobryn <inwardvessel@gmail.com>
> 
> Thanks for this but I feel like you are drastically under-selling the
> potential of this work. This will not just reduce the cost of reading
> stats but will also provide a lot of flexibility.
> 
> Large infra owners which use cgroup, spent a lot of compute on reading
> stats (I know about Google & Meta) and even small optimizations becomes
> significant at the fleet level.
> 
> Your perf profile is focusing only on kernel but I can see similar
> operation in the userspace (i.e. from string to binary format) would be
> happening in the real world workloads. I imagine with bpf we can
> directly pass binary data to userspace or we can do custom serialization
> (like protobuf or thrift) in the bpf program directly.
> 
> Beside string formatting, I think you should have seen open()/close() as
> well in your perf profile. In your microbenchmark, did you read
> memory.stat 1M times with the same fd and use lseek(0) between the reads
> or did you open(), read() & close(). If you had done later one, then
> open/close would be visible in the perf data as well. I know Google
> implemented fd caching in their userspacecontainer library to reduce
> their open/close cost. I imagine with this approach, we can avoid this
> cost as well.

In the test program, I opened once and used lseek() at the end of each
iteration. It's a good point though about user programs typically
opening and closing. I'll adjust the test program to resemble that
action.

> 
> In terms of flexibility, I can see userspace can get the stats which it
> needs rather than getting all the stats. In addition, userspace can
> avoid flushing stats based on the fact that system is flushing the stats
> every 2 seconds.

That's true. The kfunc for flushing is made available but not required.

> 
> In your next version, please also include the sample bpf which uses
> these kfuncs and also include the performance comparison between this
> approach and the traditional reading memory.stat approach.

Thanks for the good input. Will do.


