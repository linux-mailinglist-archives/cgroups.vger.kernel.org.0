Return-Path: <cgroups+bounces-4764-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DF96C971D90
	for <lists+cgroups@lfdr.de>; Mon,  9 Sep 2024 17:09:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9032DB22369
	for <lists+cgroups@lfdr.de>; Mon,  9 Sep 2024 15:09:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C64720B35;
	Mon,  9 Sep 2024 15:09:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="Vu3k6qUm"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE90D1CAA4
	for <cgroups@vger.kernel.org>; Mon,  9 Sep 2024 15:09:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725894542; cv=none; b=byfPSdgukeKmX5F1yhIWjnbZCpRwyNfMkUckpFmdHeOR4qsvAe6J0K1+x7FldYamU7n2nO024U1jqtd4hcixWoLLGsA4oMPFzIoDHLgHEWN+xRHceck2b/lobdwRe2b/6Gt2ZWjW0Assgtzwk8IwDzMFi4bSKPYIefV7oJQFtSU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725894542; c=relaxed/simple;
	bh=xPcRfbUDnlRSH5p507wqtYBgZjtSxWo7rAqcE2R7yk8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GAmI676+Hcsa5PfCqLeIIqoRoy1G940Vq3N9snvJpgX8yad8H62x4UULGvsNKmGM5YAx8rWdnHi6y+GsZd7PpD9fJeWzu65YQIs+daZKTm0ttjXl7S6tg6lJoh1hQ6VLSMPwcTtmryp5K125j9bnjpr0XGlWrqdEAtUgIlomW4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=Vu3k6qUm; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-20570b42f24so52588295ad.1
        for <cgroups@vger.kernel.org>; Mon, 09 Sep 2024 08:09:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1725894540; x=1726499340; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=XJhTFlfxhKbPWqyjtraK3mWFbHY7wyyFUxYrQtn7EAI=;
        b=Vu3k6qUmlRQzn5WTg7QeLLu+0nES5f13OH2rfp3IvCN/aiQJsPb2z24JQfQAzOMTZ1
         DK3W7tgGZBLY9XD8GXYXDSlbBm3e50/+hbQN197Vktn8Nx8huhF4yowLT89uxM00fwRd
         wpgzgr8H2olfcCdV3awmADYvdnvGfAnWSgIIw5kMcco4ldZgyvXo6cvcYmVW56qzpjEm
         H5WRQUNm67YDMhZzhxNYd5RPjCYDvjpKw7WKpGepBZvhmTw5z/naXXYuIwu4VQ6Wfxrl
         RV6zKh4eMuY3YMQ5BK55k2Xc9ThC/KEfRB5m/frpjcg2mpXqFCBCVWC+a141UplUWeYS
         G6Zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725894540; x=1726499340;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XJhTFlfxhKbPWqyjtraK3mWFbHY7wyyFUxYrQtn7EAI=;
        b=rdjkQK9+W0UB4xGzkio2CoJ+cvgBmxuPZ8pgKFPNeYpRXZMmJaFATDAwHG5R9Ugddz
         bOebWRnd8FFVQejSG6KPA1sAm+Zoy2MrmsfQKwN/4T301R+gCZ3RBXhybYFK948yOMQT
         bSNd1zwjNZlUhw3jlD1LSDFFK9vBk8sfeyxHXn7irhbsaHyN2XhB9yYkFSHJZaQBHuY7
         RgZsbpAG/YvL1brXAq4qQ5lCdszD5sKq1SE3yeI/j2yxuFKxS4pDiFL4hJQfnQOl3Zna
         DozEuRDamGk5AkfoSfNtZG3xG7Fzuk69aUwBzz29+XPVJXE4olCZie94lh0o4/5+Wm4N
         aIXw==
X-Forwarded-Encrypted: i=1; AJvYcCWcuXGe2EXXTexW/AmLTullSfL3EM8N20IaC4qxFyv/kKyCHVu2aK+erWB8YwGASI2TgCCV855w@vger.kernel.org
X-Gm-Message-State: AOJu0YxwqQYOeH7f5IHPMh+znpohjY9ucl3niYkxNDBfMrJ75Wo6kbYd
	h4stEoH8bjnAvv3QsRIC6Q0vrKJgDCkRhasRs7/ZW6AJRFG9wGOQgFTfSPcy9bQ=
X-Google-Smtp-Source: AGHT+IE4GDDZJbyQG+6N1pXP67MaHd57oGUInS3duAH669gz/mZd73jCuJO9cuvk4Qq99/EbkTfMqQ==
X-Received: by 2002:a17:902:d506:b0:207:1828:82fd with SMTP id d9443c01a7336-207182893dcmr38404705ad.28.1725894540291;
        Mon, 09 Sep 2024 08:09:00 -0700 (PDT)
Received: from [192.168.1.150] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20710f416b6sm35173015ad.294.2024.09.09.08.08.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Sep 2024 08:08:59 -0700 (PDT)
Message-ID: <be5fc442-6378-4592-bd17-2756d04e363c@kernel.dk>
Date: Mon, 9 Sep 2024 09:08:58 -0600
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] io_uring/sqpoll: do not allow pinning outside of
 cpuset
To: Felix Moessbauer <felix.moessbauer@siemens.com>
Cc: asml.silence@gmail.com, linux-kernel@vger.kernel.org,
 io-uring@vger.kernel.org, cgroups@vger.kernel.org, dqminh@cloudflare.com,
 longman@redhat.com, adriaan.schmidt@siemens.com,
 florian.bezdeka@siemens.com, stable@vger.kernel.org
References: <20240909150036.55921-1-felix.moessbauer@siemens.com>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20240909150036.55921-1-felix.moessbauer@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/9/24 9:00 AM, Felix Moessbauer wrote:
> The submit queue polling threads are userland threads that just never
> exit to the userland. When creating the thread with IORING_SETUP_SQ_AFF,
> the affinity of the poller thread is set to the cpu specified in
> sq_thread_cpu. However, this CPU can be outside of the cpuset defined
> by the cgroup cpuset controller. This violates the rules defined by the
> cpuset controller and is a potential issue for realtime applications.
> 
> In b7ed6d8ffd6 we fixed the default affinity of the poller thread, in
> case no explicit pinning is required by inheriting the one of the
> creating task. In case of explicit pinning, the check is more
> complicated, as also a cpu outside of the parent cpumask is allowed.
> We implemented this by using cpuset_cpus_allowed (that has support for
> cgroup cpusets) and testing if the requested cpu is in the set.

This also looks good to me.

> that's hopefully the last fix of cpu pinnings of the sq poller threads.
> However, there is more to come on the io-wq side. E.g the syscalls for
> IORING_REGISTER_IOWQ_AFF that can be used to change the affinites are
> not yet protected. I'm currently just lacking good reproducers for that.
> I also have to admit that I don't feel too comfortable making changes to
> the wq part, given that I don't have good tests.

Yep io-wq will have the same ignorance of cpu limits, so would need the
same love for when someone asks for specific cpus.

> While fixing this, I'm wondering if it makes sense to add tests for the
> combination of pinning and cpuset. If yes, where should these tests be
> added?

Yeah certainly add tests, liburing would be a good spot for that. That's
where the feature/regression/bug tests always go.

-- 
Jens Axboe


