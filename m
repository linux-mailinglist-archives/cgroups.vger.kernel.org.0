Return-Path: <cgroups+bounces-2886-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 440378C59E7
	for <lists+cgroups@lfdr.de>; Tue, 14 May 2024 18:50:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EEFD2283120
	for <lists+cgroups@lfdr.de>; Tue, 14 May 2024 16:50:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2E2617EBBD;
	Tue, 14 May 2024 16:50:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bC4/1VzI"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-il1-f182.google.com (mail-il1-f182.google.com [209.85.166.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FBBDF501;
	Tue, 14 May 2024 16:50:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715705417; cv=none; b=bHAMp2C1sWF+qNb++cJV4ZB5d1+eoNcxNpwzZFpw13mKKM/fHLu/trFuwtY4Q2LFqCGFcoE8AlctyjzrKLAdKFQ8WqIcdxmgV/3PmEhBmajhFDPLQAZTMOjUbBoHQCSsgoN+8TCNw2q/sbkUoFOfTYLJkbAIZuGe3rRsqMQDfDU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715705417; c=relaxed/simple;
	bh=9gvc+eV5vJLN59KuAi5BPmoIZxH5FUrEhj3EWQbcIc4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=U9rFBm7/HlRubwRTaCnCT1QECp3FJ3yCu4PRXhtaQVwmJ0kPKaZa7eHFi9kp73LTpf4Xpy1+oaxb5fQcCHkEBK3u3JuJ+BAHAa36xN1fkpPpCIpdOlRnFzysJ/Bxndl4NDqMGWjWz2U9CZGt4Q5cU7HOsvnYd+npSHtdw8MLsAQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bC4/1VzI; arc=none smtp.client-ip=209.85.166.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f182.google.com with SMTP id e9e14a558f8ab-36db3304053so2280625ab.2;
        Tue, 14 May 2024 09:50:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715705415; x=1716310215; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=14nqunY9nKXcj2uKcOEFKBKbp+gncL4/qrREVkofVOU=;
        b=bC4/1VzIGL0jATHOtT5W2PLOPcZnmxKsiJDZ7IIELti6nGAEi9lvIt/4PT87EMPpsG
         OklBCO8CytAaMzXwA2ReTN+m33le9exq1zq1NkDiqgOt2fWPfrb5M41X4Hj9D9jmLO/D
         NGgxdl+X0nh/pn2ueuZpbKKFUh00FjNQy7BZdyhK7NweYI0n7kOueYjCm+NMoEOIudIj
         zWYcxJ4xGzawHOMsJ6TCuJAAE7xFRN4ckoeOXJ9ATGty9eOO7+0eq1jEvrMpGNFBRwhC
         MfhhVhrerU7GLdRP5Hm3jIyTf9CTH8kglmPXlaUwFTyDWRsbhGt2nhJod/t+AMa5Bcnx
         8MRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715705415; x=1716310215;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=14nqunY9nKXcj2uKcOEFKBKbp+gncL4/qrREVkofVOU=;
        b=jaaWNyLOfqgnIM7nPta3yH8mIggfVL8gyMTMYjXeEvuyQzfRVGTaUcR7w/Tw5yAJJ/
         alczHH8FlbteCpyWa+gC8yY/JZYu4NRF6IyqDQvsIAo2Qkbi7fZytcdwqipGYbTHTfci
         xln9wfJyYqCg9yNRLyazvx/2W9w0BwCsfONlSfTJwUsIbRflVa5CwkfJc24SA/AakjPZ
         ShKsHwtfSMTLUYpktHECig4gPpH5yQmV3jL0DaBp+AAS7hOHji1ThtN51/MlsJhClfsr
         FC3ToOscQUxZAwHeS66xQpfkDzy5W2eYjVeYFwL6agggYrCZijo40/xpxTWAQYkiEREC
         v4JQ==
X-Forwarded-Encrypted: i=1; AJvYcCXzSHW5GdbbFcNAH7DDZUW17zwhKWThTJjhM/mFViZNJdK7eCrWf8cdVbXcj9fxcWkFOKrjGyfFisyvIr/z+nDriUwrMCEWtBh8mKfjnlK//Y1iSq0KjQYF4AMuT/nnS8Kv7ZVLkw==
X-Gm-Message-State: AOJu0YwqAXqORwyJ10SB//WzaNSytOy2PSdR4Er3A3i52Wc9XrCdRIyI
	wy8k0WhHKJNmnYUdYAm9H1lfVUO8aTcWdaExfhFmSAeUff+QFTrM
X-Google-Smtp-Source: AGHT+IGv1lQrLD/AjELeFcmHnJ8IH1HEOgtrJsRR8KQHdJP8b0LQWjX7eNcTZsBMbNoazQd1MhSmzw==
X-Received: by 2002:a05:6e02:174b:b0:36a:1104:2d6e with SMTP id e9e14a558f8ab-36cc14681bamr170385425ab.1.1715705415284;
        Tue, 14 May 2024 09:50:15 -0700 (PDT)
Received: from localhost (dhcp-141-239-159-203.hawaiiantel.net. [141.239.159.203])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-634105e103dsm8490408a12.57.2024.05.14.09.50.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 May 2024 09:50:14 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date: Tue, 14 May 2024 06:50:13 -1000
From: Tejun Heo <tj@kernel.org>
To: Waiman Long <longman@redhat.com>
Cc: Yury Norov <yury.norov@gmail.com>, linux-kernel@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Anna-Maria Behnsen <anna-maria@linutronix.de>,
	Ben Segall <bsegall@google.com>,
	Daniel Bristot de Oliveira <bristot@redhat.com>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Frederic Weisbecker <frederic@kernel.org>,
	Imran Khan <imran.f.khan@oracle.com>,
	Ingo Molnar <mingo@redhat.com>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Leonardo Bras <leobras@redhat.com>, Mel Gorman <mgorman@suse.de>,
	Peter Zijlstra <peterz@infradead.org>,
	Rik van Riel <riel@surriel.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Valentin Schneider <vschneid@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Zefan Li <lizefan.x@bytedance.com>, cgroups@vger.kernel.org
Subject: Re: [PATCH 5/6] cgroup/cpuset: optimize
 cpuset_mems_allowed_intersects()
Message-ID: <ZkOWRa_hFFhcbpVf@slm.duckdns.org>
References: <20240513220146.1461457-1-yury.norov@gmail.com>
 <20240513220146.1461457-6-yury.norov@gmail.com>
 <911ca229-4849-4fd2-8ae8-5ca653d8a5e3@redhat.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <911ca229-4849-4fd2-8ae8-5ca653d8a5e3@redhat.com>

On Tue, May 14, 2024 at 12:47:59PM -0400, Waiman Long wrote:
> > diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
> > index 4237c8748715..47ed206d4890 100644
> > --- a/kernel/cgroup/cpuset.c
> > +++ b/kernel/cgroup/cpuset.c
> > @@ -5010,6 +5010,9 @@ EXPORT_SYMBOL_GPL(cpuset_mem_spread_node);
> >   int cpuset_mems_allowed_intersects(const struct task_struct *tsk1,
> >   				   const struct task_struct *tsk2)
> >   {
> > +	if (tsk1 == tsk2)
> > +		return 1;
> > +
> >   	return nodes_intersects(tsk1->mems_allowed, tsk2->mems_allowed);
> >   }
> Reviewed-by: Waiman Long <longman@redhat.com>

I'm not sure this is worth the added code.

Thanks.

-- 
tejun

