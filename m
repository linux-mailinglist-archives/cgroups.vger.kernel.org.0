Return-Path: <cgroups+bounces-8369-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B0AC5AC658F
	for <lists+cgroups@lfdr.de>; Wed, 28 May 2025 11:19:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7EAE6189430B
	for <lists+cgroups@lfdr.de>; Wed, 28 May 2025 09:19:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 181FF275858;
	Wed, 28 May 2025 09:18:59 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2860E275842;
	Wed, 28 May 2025 09:18:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748423938; cv=none; b=T6hx5vcTTVSDBuwdePLdxe9PuGx109VvwSoAhpu0zDb2L9WMHDrmKXSjMLPONi3TAHmjdfsZP4xuSw/tN7dlnCeJ31yipekBcwwSoxROsMZqPE8tH53GPMT8OHIsgkj1HYMR8rGxGQ+1u2FxooJMnyvFcpMsaRwEhg2fSIHgH9Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748423938; c=relaxed/simple;
	bh=VZ+mBZ7sZVKrevaJyUxvu7xHNhh5PUFzarPAmfRJRUg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=m5V8AJ5p/ajbP6Sf8B8j1f45+Qe605qsl13pDqflqQnoLaNvFCi7mLuS+dVEhVbGhf4JEyZRmrwxjlxl9AbCDpwTmUykA+bbYk4W7XRngBExne4ta6+eQfyIk5QqEcK3n9HwKVT0ymYau8/DlYdiHfypL7ZkIYDGxHwfIYYxswA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-ad89ee255easo99985166b.3;
        Wed, 28 May 2025 02:18:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748423935; x=1749028735;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0pW4psWyw4mqAnBUvE51G8YcPcvTVt9THPNyFYZHPLU=;
        b=EMUd8iwUP6j0NRqLT5BRvtgqwrUVaDPAmeUGCMaGpO01fqEfXS+yN8copjyPfMuwvU
         PHWIejoUEWupIoVkBkkYxYY6hgKla8kV20FNSE+mcDUoCbS5LFIce8bngPD2shNSR3sk
         xbA1YjFbq9hNcde0iBdBSyTJbjaD2hFmD7tGPiRkEVz1k+Dbix8yKDUXcVAICv+lfoLr
         zrOqsEGgVOVR084YXYdu96kNuhkZSDPOZiB2gotM7TZABAtqGzAAWxdgpvUJKilAIF6U
         4FW9Ncj2RSNWQyT0MsptfPdC7JJOn8382vbWAJCKL4ETl+Z5WFK8fi+OIwSxkdy7GJnU
         ysyA==
X-Forwarded-Encrypted: i=1; AJvYcCUXegXyFI9+w6uAg5aCOd2uYKHRpAdYMT2RizrWksG4RZT061rj/oOcGE8BSzxobmGr+s4fKgGXwLRSgESL@vger.kernel.org, AJvYcCVSiYWZbjbtMVQmBRkUlHGsJY1OKwu1d3dDfpSkaKL1SuQDThgihGTqpm4JLpExWWeKHLQ2J6t8@vger.kernel.org
X-Gm-Message-State: AOJu0YxQjvLDv5OB0srS/z8iaSUjMPz5faiqshyw6tYoHoH+oZ2j+iRI
	dpSWKq/wtlDKJYwABck9vV6henDK/WnyCiJiFX+4GuvFvgFHFA189Byr
X-Gm-Gg: ASbGncvqGVc0QJTxCz7y91eUMMEGwWfvKddpS09XNuav2HYdoZBycY6LXemJjvtaxcU
	WQFPtwIqa/9WoM5MK+XDkKa/o5rq5zV35JGm+VYf3vdBVK2AQCFZuVD/YeYnWAyUgPtl9XOXWUX
	tci4Nk3kF1VKptkIe8o/q7Cd8BXlHwvadwnb+KEtKUkEwpTkfQ2iX/oMzzvvU7xBL1CAEcMjwb4
	me3yZs71eJXonkXQ8024+UQ7+lywYCse3QffPiASp4qJ1S11RZGSQ502C+USSljU4QDLZUF2Aru
	bbRlUbNjxUeZdzhv+pz4mOUOiRpcN8sruT7WrOXuQY3dEi584zgG
X-Google-Smtp-Source: AGHT+IGoYdO47+oM6ou2U9T7Lb1yWxp8JxvcXflAlkbBf+bOi50F2wX/HLD+grDtDSMRecSopi9I/g==
X-Received: by 2002:a17:907:25c7:b0:ad5:3156:2c06 with SMTP id a640c23a62f3a-ad85b076d18mr1584393166b.28.1748423935039;
        Wed, 28 May 2025 02:18:55 -0700 (PDT)
Received: from gmail.com ([2a03:2880:30ff:6::])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ad8a19ad4bbsm76379266b.15.2025.05.28.02.18.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 May 2025 02:18:54 -0700 (PDT)
Date: Wed, 28 May 2025 02:18:52 -0700
From: Breno Leitao <leitao@debian.org>
To: Shakeel Butt <shakeel.butt@linux.dev>
Cc: Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Muchun Song <muchun.song@linux.dev>,
	Andrew Morton <akpm@linux-foundation.org>,
	Chen Ridong <chenridong@huawei.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Michal Hocko <mhocko@suse.com>, cgroups@vger.kernel.org,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org,
	kernel-team@meta.com, Michael van der Westhuizen <rmikey@meta.com>,
	Usama Arif <usamaarif642@gmail.com>,
	Pavel Begunkov <asml.silence@gmail.com>,
	Rik van Riel <riel@surriel.com>
Subject: Re: [PATCH] memcg: Always call cond_resched() after fn()
Message-ID: <aDbU/ApoHK9SRXzv@gmail.com>
References: <20250523-memcg_fix-v1-1-ad3eafb60477@debian.org>
 <ucarls72c6j7xzhdjsbb2wj5ovlzthatmh7kzwhepvudszap4h@xetgnupdm5ui>
 <aDWN9mP3wPQnwo4m@gmail.com>
 <zxorog2mv54v5dpl5cmmkd3j4hznyxbj435hjtbtzljwspm6mt@tj446cjrclcg>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <zxorog2mv54v5dpl5cmmkd3j4hznyxbj435hjtbtzljwspm6mt@tj446cjrclcg>

Hello Shakeel,

On Tue, May 27, 2025 at 09:54:10AM -0700, Shakeel Butt wrote:
> On Tue, May 27, 2025 at 03:03:34AM -0700, Breno Leitao wrote:
> > 
> > Not sure I followed you here. __oom_kill_process is doing the following:
> > 
> >   static void __oom_kill_process(struct task_struct *victim, const char *message)
> >   {
> > 	...
> >         pr_err("%s: Killed process %d (%s) total-vm:%lukB, anon-rss:%lukB, file-rss:%lukB, shmem-rss:%lukB, UID:%u pgtables:%lukB oom_score_adj:%hd\n",
> > 
> > 
> > Would you use a buffer to print to, and them flush it at the same time
> > (with pr_err()?)
> > 
> 
> Something similar to what mem_cgroup_print_oom_meminfo() does with
> seq_buf.

Right, where do you want to flush this buffer? I suppose we want to do
it at once, in the caller (mem_cgroup_scan_tasks()), otherwise we will
have the same problem, I would say.

This is the code flow we are executing when I got this issue:

mem_cgroup_scan_tasks() {
	for_each_mem_cgroup_tree(iter, memcg) {
		ret = fn(task, arg); 		 //where fn() is oom_kill_memcg_member()
			oom_kill_memcg_member() {
				__oom_kill_process() {
					pr_info()
					pr_err()
				}
			}
	}
}

So, basically it prints one/two message(s) for each process, and goes to
2k processes, so, __oom_kill_process() is called 2k times when the memcg
is dying out.

mem_cgroup_print_oom_meminfo() seems a bit different, where it coalesces
a bunch of message in the same function and print them all at the same
time.

Another option is to create a buffer to mem_cgroup_scan_tasks(), but
then we need to pass it to all fn(), and pushing down the
replacement of printk() by seq_buf_printf(). Is this what you meant?

If so, another concern I have is the buffer size to be printed at once.
Let's suppose we have 2k "Killed process..." message in the buffer. Do
we want to print it at once? (without a cond_resched()?)

Thanks for the discussion,
--breno

