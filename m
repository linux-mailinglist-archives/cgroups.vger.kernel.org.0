Return-Path: <cgroups+bounces-5936-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AAC179F4B4E
	for <lists+cgroups@lfdr.de>; Tue, 17 Dec 2024 13:54:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9743E16F3AC
	for <lists+cgroups@lfdr.de>; Tue, 17 Dec 2024 12:54:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F44F1F3D2E;
	Tue, 17 Dec 2024 12:54:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="aWn5r3Pg"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AECAE1F131A
	for <cgroups@vger.kernel.org>; Tue, 17 Dec 2024 12:54:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734440079; cv=none; b=iZE2JAoX6Nw2Z8pOSHfLKOHlTGkLgGQN/xNLGZa/+dwp7qlCK64cceu8U/n5hKXuCEihNookgT0iXYnEgB3cyzXlvU6jlcFRN6L0CNcHY7QgW01jUrhreowxbHLO5SCEmb1ADkivyMS82cPZ2it8KsRDzdRJulfIOsQolbiaqp8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734440079; c=relaxed/simple;
	bh=enEM7izX+IlEaXtIAqMApARsvSAxsklzletXgpXLJvU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jIxvkspt4dN90cvXlv2fHEYtcpfOdyWQRiWZ8Q7Vb4mvUm/1yOr2uvJNNyZsQU+EtESkHBtZ2IBZHQCm/5pbI6A9uAOnLxkEL3zo1MXLfvR0a2aZO0gwVaSX6rVH0I1GAEQTqbQcVC3by3vjVeFkKhitSFeuhOJ5mWGmtmlAiGw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=aWn5r3Pg; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-385d7b4da2bso5012562f8f.1
        for <cgroups@vger.kernel.org>; Tue, 17 Dec 2024 04:54:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1734440076; x=1735044876; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=wNJH0bZIRp/lLbJRiuys3BD3sasknh5mv0Tb1tCrHk4=;
        b=aWn5r3PgcX+VuwKF1Qb4xaF3EGvbi5fUxCm2vWZOna3CZtgNfsNCOFduUlpkZYElkQ
         SPdqDxqgv3AAdJUPSIkvm/t4MvFlla4Q18kVdtvJsy9cOtmdX2Z5DQOoGxIe6U8h1sf7
         gDu5WHDdf2P0e3ePy+Zzx21sJG9Y2yNwDGLKc5YjTrHVKah18RE1oVSQkmqbkf4m2cf1
         9MfPzcYKK0zjqNeZsc/MRYoPRA9UeFga+4Tox3unPEHp8BQHE4GG63eN1DUGHsObyI0M
         yf+1QaSteR9vX1WeN7r/RT6Tktsg9Fc92G4QKM3sh92DmY744qe95yBocj5ZX41kOWNM
         ihnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734440076; x=1735044876;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wNJH0bZIRp/lLbJRiuys3BD3sasknh5mv0Tb1tCrHk4=;
        b=mXdqz3pf0ERSpG7DJ7BPPwXOVHIayF6KjlBdPy8AKvCW3sR9K2oxpPEKIG8W6O3Pas
         c/JZZxBWKxbKSyckufDcLt0j4D3frhCSpiIbIaUhF5jk8GbRQypg+LjexA5f1htUIEOV
         Oq4uIdBhNeYcS1sR/SnwmP9tVHRy3KaFXnVKA2jrbtH5BmR2ql2ahWbYCpBqqX1ib+3F
         GMBepsMmbfX1ioqGZUWu4iKSecSMOZH1ijzJz4evCiZWDO0utkyUpDLZPJHsAlCh4bZN
         QzfEuNU6JOKg7wOiPkwA1KTOOIHkTNVPT6lv2OQW/KUzjw9/iU1mNa4iwaJu+aEPWlgl
         Q33Q==
X-Forwarded-Encrypted: i=1; AJvYcCVMULYYOSzfOmGglJRPE85At5S54xekbcSh3pRfCE3MpA/iFF6q3qxb4q/v8ZxpH98ZlAa0433w@vger.kernel.org
X-Gm-Message-State: AOJu0YydmeEf1e1cyBcpKjeKBKxvpbFmVthIATd52qOeXSp+CI9fM3B0
	zHbUeOx1n6E1s2DpQUcYe4btdPRREiebo24I2gjQcdx0SFvos3xOkAS8uKYbUaI=
X-Gm-Gg: ASbGncuKE0oyAGWFAOTr5gDkfgsqb8g5SVQqoXVtizcEF82nZ8MYvf9XjYbHrdNai4u
	8vyf8LIjwpbaiSCCkBrcNyIq9Qze8vquOWA3eAqokToCUM+/mPBiz/BHsYc3nOas+Q497q5wHGf
	NDiWd6qZzpaTALk4BMBEKHvdbw+i9a5J1Zor9iMk1Y7SOs8BzsDleQgBv7UYUrR/P0HRbfEoI2m
	Lhah6nUN0sCOHX86eSb0/bjM7epxo87B1kWoyVjru04AY1vkOzWEtRFMq5jaXtS/gk=
X-Google-Smtp-Source: AGHT+IGIkCksbdZEfvo6ki5xx29/1TnH2HLfVEMtjsycZHejT40HWMLMjlwqoedRINBd6o/828MIhA==
X-Received: by 2002:a5d:5886:0:b0:385:f66a:4271 with SMTP id ffacd0b85a97d-38880ac61f7mr14775811f8f.4.1734440076073;
        Tue, 17 Dec 2024 04:54:36 -0800 (PST)
Received: from localhost (109-81-89-64.rct.o2.cz. [109.81.89.64])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aab963cdfa5sm442501466b.199.2024.12.17.04.54.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Dec 2024 04:54:35 -0800 (PST)
Date: Tue, 17 Dec 2024 13:54:35 +0100
From: Michal Hocko <mhocko@suse.com>
To: Chen Ridong <chenridong@huaweicloud.com>
Cc: akpm@linux-foundation.org, hannes@cmpxchg.org, yosryahmed@google.com,
	roman.gushchin@linux.dev, shakeel.butt@linux.dev,
	muchun.song@linux.dev, davidf@vimeo.com, vbabka@suse.cz,
	handai.szj@taobao.com, rientjes@google.com,
	kamezawa.hiroyu@jp.fujitsu.com, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
	chenridong@huawei.com, wangweiyang2@huawei.com
Subject: Re: [PATCH v1] memcg: fix soft lockup in the OOM process
Message-ID: <Z2F0ixNUW6kah1pQ@tiehlicka>
References: <20241217121828.3219752-1-chenridong@huaweicloud.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241217121828.3219752-1-chenridong@huaweicloud.com>

On Tue 17-12-24 12:18:28, Chen Ridong wrote:
[...]
> diff --git a/mm/oom_kill.c b/mm/oom_kill.c
> index 1c485beb0b93..14260381cccc 100644
> --- a/mm/oom_kill.c
> +++ b/mm/oom_kill.c
> @@ -390,6 +390,7 @@ static int dump_task(struct task_struct *p, void *arg)
>  	if (!is_memcg_oom(oc) && !oom_cpuset_eligible(p, oc))
>  		return 0;
>  
> +	cond_resched();
>  	task = find_lock_task_mm(p);
>  	if (!task) {
>  		/*

This is called from RCU read lock for the global OOM killer path and I
do not think you can schedule there. I do not remember specifics of task
traversal for crgoup path but I guess that you might need to silence the
soft lockup detector instead or come up with a different iteration
scheme.
-- 
Michal Hocko
SUSE Labs

