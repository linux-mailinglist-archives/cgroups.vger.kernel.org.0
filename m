Return-Path: <cgroups+bounces-6737-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 88A11A48CE7
	for <lists+cgroups@lfdr.de>; Fri, 28 Feb 2025 00:44:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 710403B58EA
	for <lists+cgroups@lfdr.de>; Thu, 27 Feb 2025 23:44:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22A711BD9D0;
	Thu, 27 Feb 2025 23:44:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JNGNFdkI"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A2DC276D27
	for <cgroups@vger.kernel.org>; Thu, 27 Feb 2025 23:44:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740699858; cv=none; b=j63QOLzHrq7MCSxxCFntk0QAGUhacpk45ZvcNcgZMviF7yanMdUsSmGk0grZaH5JW1OUuk0vQkpdNtRfSGr1DKaAqtkqQZR3cfLJeQ/+bc18EyYERy7iUcEubN1rk7efkEmnBG7nR7s6IPEdfMPUul6eFpQ91Zl4b6OpoY4qgzA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740699858; c=relaxed/simple;
	bh=JjbUWYIw6xsJEOtYZYLmKqAor18TBTuKYf5Z+HUkU5o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bsGkEorzyDPzNC4uk7cm/sEm0B7dGuMZ0pBSlFujTitVqeL5OnVFSFzSTuMsKMzovL8XeSUn2YI8pN9gUddjoLo1EvjyDhn+aPjLOSFh/FnpiiP3hgic9Yv8WNQ3XSuDRWyhC6IjKL+hfx5MZWA2MAA6byYyGm5UX6u7wsqYG1k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JNGNFdkI; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2211acda7f6so35642665ad.3
        for <cgroups@vger.kernel.org>; Thu, 27 Feb 2025 15:44:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740699856; x=1741304656; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=HAUpca2R3d0U2hR0ll37Jv2ikqDEb2N9yLFXzqEDzzM=;
        b=JNGNFdkIM2zBFDehM6deI7wtO3ffQbOkVHgIj3O0RllsWuXrn4DJ52nIsTwoixy4rX
         jfTb8hpTFu9GaPGPci1yVNDkF9q2aE7jPWedGfWSiBNBLPB7lN/5AuOqRryDMxcFS+RG
         zJfjIayKCftVtFcjhlwgiaof+N6wcJQ2BWNHlyH9jKRcaTcBopTwAt2zw+I0oiaiMIod
         tAnfjPkHjKtetXompRdFFGEijIex3YgFBHaHUV8V22y30uYGIlMzCyVrZkJHVtkT7ILq
         QHPGnqOVp26myY2RTb5U8IMypJ+OvjWruoKIRPgrUV4g0MDwTcPhE8ciQXqEPILn7a28
         VjAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740699856; x=1741304656;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HAUpca2R3d0U2hR0ll37Jv2ikqDEb2N9yLFXzqEDzzM=;
        b=WhZKq043M2sz15loqDlVdoyk/b4mRc3Rbm5pXaKwAZ15NUfbB4K9JQoVi1ACn6a0Um
         Y62qaIfoQTv12/d+hC9Y6NrXGWA+W6AXKZewpEMOc4B2DaIk1mL5j0EmYiITxgbcdWAf
         +zXhOU7zrjZVPQ8CrWBEH/biNgLNJ8PDiwOzx84vvdR32N40H8o1awylLkK1vVp0s78H
         xiNhbcYiQJNRRWAo10P3umJr9kYSszUWC4fmolzVz5Y8Z+RV83SsrU7m7N8ZCcZ9soYn
         JezXc1vcfLNB14AzDL41RhkMTRuv6fI34HkYj/tHweLeXYpzu+zob9wFDVGlCf3AnuPM
         WIFg==
X-Forwarded-Encrypted: i=1; AJvYcCVbaNSqlPupNyBpvzGRrmYnXb9eOLcHgluKcyI0kFgp6NBhSfiLOuvsdPDnTCHzJMgULPZoVGpm@vger.kernel.org
X-Gm-Message-State: AOJu0YzKXvnsJZYpS5dHO1LEiBcPgYtH+nFcrlzXWyPypJWHLQrrd23M
	+4Zr302gjq8YuWvajuskPVr76Tq0FZSCoSZCBEuSwOHXpu6rG/LhNcEmQQ==
X-Gm-Gg: ASbGncviIUOZbm8stfQTL1qSrwgUKA5MqadrC1aCpqHZYtpDT0v4ZS8SSTwnmdnwKyu
	3uctO8ncKoYUXMpya8KekFUchr0ZeAcz7YBU3Of//Mtrm4HB8B7Ol6XOajRz1zKM3nGaKb6JD/A
	+NDIlMkCnP+8yigpqWY8GAm6kV3KHaxvC1pba80PLeuOGB3PlpIseHi52K4awh+voqYW4mq8hgH
	WHWqA6Qc/3Wiv14m6s29y9BnE36qCD2sDOcA8P4trQZTjOV4WYl/iPx0ADlC2ilP+nr+SHkvBEx
	0+4iFtdzjG4dm0qZ8VlDj9Xly2XkhjWkVeUB835pvCoE6XEtWZr6F40cm9I=
X-Google-Smtp-Source: AGHT+IH7yoAmJXvNFYIfB3be6p4ODNNjXp8tXvLrOZ8JAxx0oD/Lz+Hx7TMRdvkSQJypw7aCuRdCVg==
X-Received: by 2002:a17:90b:3b8e:b0:2fa:228d:5b03 with SMTP id 98e67ed59e1d1-2febab7a2e4mr1771255a91.19.1740699855619;
        Thu, 27 Feb 2025 15:44:15 -0800 (PST)
Received: from ?IPV6:2a03:83e0:1151:15:8fb1:8b78:c871:aacd? ([2620:10d:c090:500::4:4d60])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2fe825d2b85sm4455886a91.26.2025.02.27.15.44.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 Feb 2025 15:44:15 -0800 (PST)
Message-ID: <bbb633a4-7007-4444-a391-3305a9fc8ffa@gmail.com>
Date: Thu, 27 Feb 2025 15:44:12 -0800
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/11] cgroup: separate rstat trees
To: Tejun Heo <tj@kernel.org>
Cc: shakeel.butt@linux.dev, mhocko@kernel.org, hannes@cmpxchg.org,
 yosryahmed@google.com, akpm@linux-foundation.org, linux-mm@kvack.org,
 cgroups@vger.kernel.org, kernel-team@meta.com
References: <20250218031448.46951-1-inwardvessel@gmail.com>
 <Z7dPZ9dNcaYuT6SA@slm.duckdns.org>
Content-Language: en-US
From: JP Kobryn <inwardvessel@gmail.com>
In-Reply-To: <Z7dPZ9dNcaYuT6SA@slm.duckdns.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2/20/25 7:51 AM, Tejun Heo wrote:
> Hello,
> 
> On Mon, Feb 17, 2025 at 07:14:37PM -0800, JP Kobryn wrote:
> ...
>> The first experiment consisted of a parent cgroup with memory.swap.max=0
>> and memory.max=1G. On a 52-cpu machine, 26 child cgroups were created and
>> within each child cgroup a process was spawned to encourage the updating of
>> memory cgroup stats by creating and then reading a file of size 1T
>> (encouraging reclaim). These 26 tasks were run in parallel.  While this was
>> going on, a custom program was used to open cpu.stat file of the parent
>> cgroup, read the entire file 1M times, then close it. The perf report for
>> the task performing the reading showed that most of the cycles (42%) were
>> spent on the function mem_cgroup_css_rstat_flush() of the control side. It
>> also showed a smaller but significant number of cycles spent in
>> __blkcg_rstat_flush. The perf report for patched kernel differed in that no
>> cycles were spent in these functions. Instead most cycles were spent on
>> cgroup_base_stat_flush(). Aside from the perf reports, the amount of time
>> spent running the program performing the reading of cpu.stats showed a gain
>> when comparing the control to the experimental kernel.The time in kernel
>> mode was reduced.
>>
>> before:
>> real    0m18.449s
>> user    0m0.209s
>> sys     0m18.165s
>>
>> after:
>> real    0m6.080s
>> user    0m0.170s
>> sys     0m5.890s
>>
>> Another experiment on the same host was setup using a parent cgroup with
>> two child cgroups. The same swap and memory max were used as the previous
>> experiment. In the two child cgroups, kernel builds were done in parallel,
>> each using "-j 20". The program from the previous experiment was used to
>> perform 1M reads of the parent cpu.stat file. The perf comparison showed
>> similar results as the previous experiment. For the control side, a
>> majority of cycles (42%) on mem_cgroup_css_rstat_flush() and significant
>> cycles in __blkcg_rstat_flush(). On the experimental side, most cycles were
>> spent on cgroup_base_stat_flush() and no cycles were spent flushing memory
>> or io. As for the time taken by the program reading cpu.stat, measurements
>> are shown below.
>>
>> before:
>> real    0m17.223s
>> user    0m0.259s
>> sys     0m16.871s
>>
>> after:
>> real    0m6.498s
>> user    0m0.237s
>> sys     0m6.220s
>>
>> For the final experiment, perf events were recorded during a kernel build
>> with the same host and cgroup setup. The builds took place in the child
>> node.  Control and experimental sides both showed similar in cycles spent
>> on cgroup_rstat_updated() and appeard insignificant compared among the
>> events recorded with the workload.
> 
> One of the reasons why the original design used one rstat tree is because
> readers, in addition to writers, can often be correlated too - e.g. You'd
> often have periodic monitoring tools which poll all the major stat files
> periodically. Splitting the trees will likely make those at least a bit
> worse. Can you test how much worse that'd be? ie. Repeat the above tests but
> read all the major stat files - cgroup.stat, cpu.stat, memory.stat and
> io.stat.

Sure. I changed the experiment to read all of these files. It still 
showed an improvement in performance. You can see the details in
v2 [0] which I sent out earlier today.

[0] 
https://lore.kernel.org/all/20250227215543.49928-1-inwardvessel@gmail.com/
> 
> Thanks.
> 


