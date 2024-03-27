Return-Path: <cgroups+bounces-2193-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 41FE688F120
	for <lists+cgroups@lfdr.de>; Wed, 27 Mar 2024 22:43:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E7CE71F2E427
	for <lists+cgroups@lfdr.de>; Wed, 27 Mar 2024 21:43:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EF2B153823;
	Wed, 27 Mar 2024 21:43:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Hl9co3W7"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CACAF153592
	for <cgroups@vger.kernel.org>; Wed, 27 Mar 2024 21:43:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711575797; cv=none; b=VN9MhYuGqUrXfinIBsfBweku7zO5gX7XLQSEa7XvfU9AONlqVo3r6Lc9TpZi5Qc9HsRk8oRKi+nAcZd1nbUFAtTxs3T/8RL2B8VX0B7MoX1xv1N6LmAPw7yJI6EeFaHnKbaQLDoMnGNuti4mkyUHTGTgDOk9mh5OAHNpgCAMn9Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711575797; c=relaxed/simple;
	bh=M0QPKV8wHC3lRwLrv8lLOdkp2FSVZKQusxhUfr+c44c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AiEQTiyxeyVmYYpAlG+G+CoMTr7FlL4qWjjoAUqcHRTiH+1DTYEQfxhQXGrvV5eCWtKrc+eMu+6Nas+CzSGgroMulZlL7ppiMdFA8xEAux77/l1PWDavxVDWzRp08CA5cnj3diNXFNBjz7ussiCDZHh76xVvOfNaEj8SZV9h8GQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Hl9co3W7; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-29df0ca87d1so290086a91.2
        for <cgroups@vger.kernel.org>; Wed, 27 Mar 2024 14:43:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711575795; x=1712180595; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hoxJLgxSlTI3pFFjtPl7owccMa71GWa6kzErD6HGJwY=;
        b=Hl9co3W7OlJZx/TlMkHvovRE5pBgUZxdYzzw0TOG2Tiv+6GbZmkenb5Pr7YdERDaLG
         mL8RBK1iqatwZWKhHYmoClQ8FKdnE/RGdnS5C8JWjbWK1SM3xckGK97FcSG4TYTXlM9b
         2Ez4Oze3YxIZ6CGzLY4rW7gJonYDn5PgaTmk4rmysHIOu3EYPMO/oqLSE/u3C5Pua7F8
         hniKX5VANSnYf/ESI7HB3kp9SmKfc292UL3oxNd7wO50LPsLObMPd3g8YAxFRtZUPanx
         nOs1uWkddE6e8F7FKAmnpmc6RgvaLw9thZxSnQd6dmzcAjzaHgyNLa6yhCzEgRaIFQLU
         uQtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711575795; x=1712180595;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hoxJLgxSlTI3pFFjtPl7owccMa71GWa6kzErD6HGJwY=;
        b=JpbImg+nlWOOngZhMkF+NVKISVwJF37ei1OV7o7+iKp5OL+w336r2RcW/rxOtC26zq
         FKG+69jDia+1UU9g5IZYsrXMVAXrr56U/DX55akjZRj8UHssF9ZJKS5MTRMXlqJSi6PK
         QxyjNxzCwHvAnA7etSvlide9INiw17rRFsjWVX9L4UpChUEuJ//qDRCP7385/3yYfcgp
         4I+6+fiDSvRnAQb+58Do8FlWOqciLZpw0lzD8fxVm+2V//tUw0jYDnp7ITPToblUwpcE
         2VoLnElCyaPn/ujbsd/wDVXfqE4KwNh7/U2cciGTGJO2jYgj3kSAAJJOaKYYpBs4SonP
         EyTQ==
X-Forwarded-Encrypted: i=1; AJvYcCWNt2Mf2sylUXmhbbCXgKArZZXLGxCvFTFCei/vz++DFT/oF2yMT0SzagSgeXx+Zs1GVA71S02Tz2RNi0bLiUDUoBcQBCEDSQ==
X-Gm-Message-State: AOJu0YwiDshGpiSRFn5Q1pprzBeoPBYyQs+WS9u6dxQU0oQvnSdrNR9e
	8nwt8IHsDWK2CT/u+/MoNp3gPO0f19UmY1HR64qX9vAASh0e8LoI
X-Google-Smtp-Source: AGHT+IHSD/NVXodI4vi8+74MK+Iqbs+4RxO1WK7XXhoaD3d76b3S6It/Mk076Yc1SThqAjIMNaFq5A==
X-Received: by 2002:a17:90b:4e86:b0:2a0:20b5:7f1a with SMTP id sr6-20020a17090b4e8600b002a020b57f1amr908816pjb.37.1711575795132;
        Wed, 27 Mar 2024 14:43:15 -0700 (PDT)
Received: from localhost ([2620:10d:c090:400::5:4d4e])
        by smtp.gmail.com with ESMTPSA id hx20-20020a17090b441400b0029c61521eb5sm1699982pjb.43.2024.03.27.14.43.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Mar 2024 14:43:14 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date: Wed, 27 Mar 2024 11:43:13 -1000
From: Tejun Heo <tj@kernel.org>
To: Waiman Long <longman@redhat.com>
Cc: Chuyi Zhou <zhouchuyi@bytedance.com>, cgroups@vger.kernel.org,
	hughd@google.com, wuyun.abel@bytedance.com,
	hezhongkun.hzk@bytedance.com, chenying.kernel@bytedance.com,
	zhanghaoyu.zhy@bytedance.com
Subject: Re: [problem] Hung task caused by memory migration when cpuset.mems
 changes
Message-ID: <ZgSS8eKks9jZx4mc@slm.duckdns.org>
References: <20240325144609.983333-1-zhouchuyi@bytedance.com>
 <ZgMFPMjZRZCsq9Q-@slm.duckdns.org>
 <d8e8b000-7d09-4747-82ec-bf99a73607ee@redhat.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d8e8b000-7d09-4747-82ec-bf99a73607ee@redhat.com>

Hello,

On Wed, Mar 27, 2024 at 01:14:49PM -0400, Waiman Long wrote:
...
> > @@ -2718,11 +2739,6 @@ static void cpuset_migrate_mm(struct mm_struct *mm, const nodemask_t *from,
> >   	}
> >   }
> > -static void cpuset_post_attach(void)
> > -{
> > -	flush_workqueue(cpuset_migrate_mm_wq);
> > -}
> > -
> >   /*
> >    * cpuset_change_task_nodemask - change task's mems_allowed and mempolicy
> >    * @tsk: the task to change
> > @@ -3276,6 +3292,10 @@ static int cpuset_can_attach(struct cgroup_taskset *tset)
> >   	bool cpus_updated, mems_updated;
> >   	int ret;
> > +	ret = schedule_flush_migrate_mm();
> > +	if (ret)
> > +		return ret;
> > +
> 
> It may be too early to initiate the task_work at cpuset_can_attach() as no
> mm migration may happen. My suggestion is to do it at cpuset_attach() with
> at least one cpuset_migrate_mm() call.

Yeah, we can do that too. The downside is that we lose the ability to return
-ENOMEM unless we separate out allocation and queueing. Given that
flush_workqueue() when migration is not in progress is really cheap and the
existing code always flushes from post_attach(), I don't think it's too bad
but yeah it widens the scope of unnecessary waits. So, yeah, what you're
suggesting sounds good too especially given that migration is best effort
anyway and already depends on memory allocation.

Let's see whether this works for Chuyi and I'll post an update version
later.

Thanks.

-- 
tejun

