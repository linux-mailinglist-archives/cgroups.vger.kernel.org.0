Return-Path: <cgroups+bounces-9376-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B76CB33BBA
	for <lists+cgroups@lfdr.de>; Mon, 25 Aug 2025 11:53:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2B768164359
	for <lists+cgroups@lfdr.de>; Mon, 25 Aug 2025 09:53:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D45022D3209;
	Mon, 25 Aug 2025 09:51:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="E1YSSVrl"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CFCE2D0C9D
	for <cgroups@vger.kernel.org>; Mon, 25 Aug 2025 09:51:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756115474; cv=none; b=eWCxlV6rUerfnMmz07xmzV+Ws5SHH/KCdH27LoVVd+TrCJQTPfpVvEUBU1jphCNlM2dt6MuGHw1QoBGO3JOhL2zoHxV1EMr1AbRZCqzZ8qAWmTekIIxZbb1NVMh7O8e9e74/RhB3WwD30CVcqer35XayNcK+Qa/9NaWt3KxD2fA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756115474; c=relaxed/simple;
	bh=B8eCYEono40PCIy16xmaC4Aox2ZtXZbrtkZF8FCENiM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=m0t93ZT6LkmXf0E9D7MJ6VhgN8R5kB0keuCunN24l1Q1ksyHY3dO+vOQmZ9ujvLOf37m9bmsjt5xv4SQmBO9chKQ1fh6UzdC/AtMG6q9omFLLuhtDyhC+Lg/7EM8n/CXkxylNVObcyXspT/+05NSckF319Yy12G4zmfZqZioHl4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=E1YSSVrl; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-770530175b2so897786b3a.3
        for <cgroups@vger.kernel.org>; Mon, 25 Aug 2025 02:51:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1756115472; x=1756720272; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=91s1cIGRQAxrumxrJ8ni6aEx18e/r1sz4gPLC81PIgY=;
        b=E1YSSVrl8O1J/DGQWQkRBjERagRt0CuIMoYZFNRkgUW2Y9BQf3qFeYQRmUqFSaHT6O
         bFkk/QetwGsQXg8DKAjBdYNpQycSlMQ2De0vvYOVRfRu7Gv9HyNMwtWlMXH66KFoyevZ
         F9um6xbXyAkHdC9p3Mx1m10vpMTfmoz+3BohjFROf2HSDHY+3Daqr+kLdTE22bhx95V9
         ExkFTB8d+eEmMphg+c5cjrbHv8aTtiC2dRztLHWxEnQcLWk/yX+zGK/MGq1BIlkkosYt
         THlG0bmrm8+pEKSmXcfNTCapzIo3fsPZfN67EeBEs+qkUjj6aOV7wQmd8EOwyEFnVRpo
         Edxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756115472; x=1756720272;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=91s1cIGRQAxrumxrJ8ni6aEx18e/r1sz4gPLC81PIgY=;
        b=XKOenuvHWM0FAvmmQII+BNPSi2kH+IqqSljqNQZ8rE9LAEla/5bDdcfWP3tEMywa3x
         dcSAWprQgrCS5wrQ/eKmDQ+lmRRXjFdkPJiAgSl1FMH69zMTcNda1Q8Vs4b7p7Au9vou
         28lmMcQe/W4xKd2Uvf+RMnw1omW6qnK6cHuCZpTKWJ5QSguaKyhDgOcl0m2xVD/sIoeZ
         pPRZfw/624DbC5I2EtQJex1m1J7P45ZkqfawqKDVjciNbaEcFns6PRaGL8ISlV4cTkC+
         +qo1jQwff3vfjmvve6iddWLlo1BvpTjsOsMgVkhXjmbfthQvn47+trmi1lk6f0REFT5F
         57iA==
X-Forwarded-Encrypted: i=1; AJvYcCX20essYBFbiVwB3Ws1Zs8wPZNoy52LOe5rTRXEVxkah8W9enTKJa3weC06g/r5v87EsGXkmDxE@vger.kernel.org
X-Gm-Message-State: AOJu0YyS53fLJXWEpFuOCbXtdqN+BB9fmFQpYjAm9OBOh/gF0gUOJ/go
	ACU0bNbNlEwDchT3dlpgFcR/xvjK2j3Hq84eLSP3cOVGFhInPCCGYVVhFsJbNOrfVQ==
X-Gm-Gg: ASbGnctB3XLN2Pt7RSYZFh5+3wlAb2No0uV8eipbAkfGVRKZZUj6K5slUnyeU+jTNVb
	JGQh6Hpti4AQAF0xdbKcgf9+sOKKS5xobiNXjjDw7SokkPpp0N+iAo4HWkJYXybRsp6ki5bIDJp
	wVocTawwI8ha2Ak0barqRA+dLCguItnOE1oScyfamVzamdnFc0fO2xdqTfeVLWAWlOyjZMKkW3k
	VjKkuBPE24Iql23G3pob6gukyFIsh/169+9+uLCnt3rbtfa99u9F9Wpyvgewa+m0g5n6K8ejwUE
	w02E//9VQ9MaOXAaelN/7RLoF6Bir+33+VpdWmHGkgpP4JKyf7u/ZyspBfv2yahqtlFueci4OlP
	Ge8B9VPhgs/iAAfbdMzNGK9xtk8M2NJEVQhp5ncx5QEFuH2I=
X-Google-Smtp-Source: AGHT+IFKmShdsyMlmj4cT5JRWT7LwYbqWBv7GzkGKLvpKSJg5ombkdXo91DBer2NpWN+oCdJY5Gk/A==
X-Received: by 2002:a05:6a00:2288:b0:770:3064:78fa with SMTP id d2e1a72fcca58-77030647984mr14107031b3a.2.1756115472294;
        Mon, 25 Aug 2025 02:51:12 -0700 (PDT)
Received: from bytedance ([61.213.176.56])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-770b5bed408sm3213674b3a.18.2025.08.25.02.51.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Aug 2025 02:51:11 -0700 (PDT)
Date: Mon, 25 Aug 2025 17:50:56 +0800
From: Aaron Lu <ziqianlu@bytedance.com>
To: xupengbo <xupengbo@oppo.com>
Cc: bsegall@google.com, cgroups@vger.kernel.org, dietmar.eggemann@arm.com,
	juri.lelli@redhat.com, linux-kernel@vger.kernel.org,
	mgorman@suse.de, mingo@redhat.com, peterz@infradead.org,
	rostedt@goodmis.org, vincent.guittot@linaro.org,
	vschneid@redhat.com
Subject: Re: [PATCH v2] sched/fair: Fix unfairness caused by stalled
 tg_load_avg_contrib when the last task migrates out.
Message-ID: <20250825095056.GA87@bytedance>
References: <20250806071848.GA629@bytedance>
 <20250806083810.27678-1-xupengbo@oppo.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250806083810.27678-1-xupengbo@oppo.com>

Hi xupengbo,

On Wed, Aug 06, 2025 at 04:38:10PM +0800, xupengbo wrote:
... ... 
> 
> It actually becomes:
>     if (cfs_rq->tg_load_avg_contrib > 0)
> if cfs_rq->tg_load_avg_contrib == 0 , it will be false. As it is an unsigned
> long, this condition is equivalent to :
>     if (cfs_rq->tg_load_avg_contrib)

I suppose we have reached a conclusion that the right fix is to add a
check of cfs_rq->tg_load_avg_contrib in cfs_rq_is_decayed()? Something
like below:

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index af33d107d8034..3ebcb683063f0 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -4056,6 +4056,9 @@ static inline bool cfs_rq_is_decayed(struct cfs_rq *cfs_rq)
 	if (child_cfs_rq_on_list(cfs_rq))
 		return false;
 
+	if (cfs_rq->tg_load_avg_contrib)
+		return false;
+
 	return true;
 }
 
If you also agree, can you send an updated patch to fix this problem?
Thanks.

