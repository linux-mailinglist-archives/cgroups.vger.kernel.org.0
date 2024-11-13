Return-Path: <cgroups+bounces-5535-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DA919C74F1
	for <lists+cgroups@lfdr.de>; Wed, 13 Nov 2024 15:59:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BB24F1F25C35
	for <lists+cgroups@lfdr.de>; Wed, 13 Nov 2024 14:59:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BADCB13A268;
	Wed, 13 Nov 2024 14:58:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="B9l3MHW4"
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14D8938389
	for <cgroups@vger.kernel.org>; Wed, 13 Nov 2024 14:58:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731509925; cv=none; b=hlX7utT/3oopLYUyvD2F2PPICo+ETnqFchZL0JuuXtgbYDQqbfOfaU2L9246U9QrSCfWG1mRqJHiCD1xkUWxdSmpkTwqvEto8PEYopGZsVrik+3QwGBVTW/U/MfIGmlUPjg2oBwPnyYZq7XBLHa1d6POgl4Xkn8JVhJ8nH+I8Bk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731509925; c=relaxed/simple;
	bh=AppAQ7wltJ/yoE0Id1YlcSnmvkFhTnGrtfCF7tE/z+c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Da/N5eyfGf40C0W6KcVJqBAjXOYS8zASOlLlT2coTfZmdRuD8Iec0zSW6sMxj4MDHcwv4m9lpud4JXJQ/VvCVuA9sOWfDrlIBWNgxEMCexRTJaPmzmygwG3BPfGvAnBixi+mstX+W+dZ+OsUxqbos0KzOjjPPIbBCPBiPuVzgZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=B9l3MHW4; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1731509923;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Qkatl3uPxKN3f5OhVtGvUoCEjJCTENaafdUlHbDnvl8=;
	b=B9l3MHW4RJi1xiEcq4hQhqdbBleQ9W5N4WgW+OrhqT0QxVQKnUlwAWnI/lTua/20xIcNoP
	lmvphCYql1Gt0zMO6NWTZPF61+D2LoQtkHZDAZTTYryf3UPQZnH/Z54nOSxLQLRJAWcNcA
	BE+IZDN5LJQJnEOdOtOmJSYky6kmw08=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-455-SkDf80CiN7GCe4UBe6ofVw-1; Wed, 13 Nov 2024 09:58:41 -0500
X-MC-Unique: SkDf80CiN7GCe4UBe6ofVw-1
X-Mimecast-MFC-AGG-ID: SkDf80CiN7GCe4UBe6ofVw
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-37d609ef9f7so4005028f8f.3
        for <cgroups@vger.kernel.org>; Wed, 13 Nov 2024 06:58:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731509920; x=1732114720;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Qkatl3uPxKN3f5OhVtGvUoCEjJCTENaafdUlHbDnvl8=;
        b=G0ql9Rtkz2zHINxxHR/RL3+8ki3PdESislsF3PfTxYqjjbEHKLlXIxphafrnQuT1AX
         1IU+54i6IgXwq7YDOYn4Z7FX8jsLyPVg35ehpBpmV/n12yp1qwfJKaDk3lvqptaDltjs
         z0MhKxzggssrSktWuzkc6KntZKeVKk3fYf0+Ys4gjOnvJD86uJ+k1ZcJsXDxf+h63r3g
         1RhbMXjFKUDXdG0dlM8eFUAECqezwIUY+rOVSLHpI3FOcWgmlet0KxHjqQQyjltCrOW+
         xD1nYwO0faEIAcVwGtJkBM6e/SZNOHo0ps3cCgDEBxIArYuBHhJH56rv+bBr/2nZkxPd
         Yg9g==
X-Forwarded-Encrypted: i=1; AJvYcCXaa6r/wcH+Erqi1ZUYPPcS6nhsIm6kikujc+gcJlTHUHnXCcAjIWiDhufrRFoX4WTsQU8Sd13d@vger.kernel.org
X-Gm-Message-State: AOJu0YyBN8DqpRghjVrXWvaUvWqx5mFlBPredbhX9eYaMjf3sDGLtHiq
	5Mn6DUj8JsnwO2EJpO0SAMlAjbZr/Z5QIqb/ErGjIvcb836fAccmJ2aEe7uTCM5kmvA0iazCCMe
	w+F0Xf03a0DaJPGZIq6IRzB22YnzcS/7V1zbr5TvzdD0XX95tIuqDeRo=
X-Received: by 2002:a05:6000:186c:b0:37d:5129:f454 with SMTP id ffacd0b85a97d-3820df61020mr2619231f8f.15.1731509920509;
        Wed, 13 Nov 2024 06:58:40 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFSdAOXbIQrKY4kjfQvG0fVihJT7Qe0ao00JJmqS399/ErbTtnTr9GRovWUnGjqJfmbUxq5Qg==
X-Received: by 2002:a05:6000:186c:b0:37d:5129:f454 with SMTP id ffacd0b85a97d-3820df61020mr2619199f8f.15.1731509920177;
        Wed, 13 Nov 2024 06:58:40 -0800 (PST)
Received: from jlelli-thinkpadt14gen4.remote.csb (host-80-47-4-194.as13285.net. [80.47.4.194])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-381ed970713sm18871309f8f.3.2024.11.13.06.58.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Nov 2024 06:58:39 -0800 (PST)
Date: Wed, 13 Nov 2024 14:58:37 +0000
From: Juri Lelli <juri.lelli@redhat.com>
To: Phil Auld <pauld@redhat.com>
Cc: Waiman Long <longman@redhat.com>, Tejun Heo <tj@kernel.org>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Michal Koutny <mkoutny@suse.com>, Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	Qais Yousef <qyousef@layalina.io>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	"Joel Fernandes (Google)" <joel@joelfernandes.org>,
	Suleiman Souhlal <suleiman@google.com>,
	Aashish Sharma <shraash@google.com>,
	Shin Kawamura <kawasin@google.com>,
	Vineeth Remanan Pillai <vineeth@bitbyteword.org>,
	linux-kernel@vger.kernel.org, cgroups@vger.kernel.org
Subject: Re: [PATCH 2/2] sched/deadline: Correctly account for allocated
 bandwidth during hotplug
Message-ID: <ZzS-ncIOnEgrOlte@jlelli-thinkpadt14gen4.remote.csb>
References: <20241113125724.450249-1-juri.lelli@redhat.com>
 <20241113125724.450249-3-juri.lelli@redhat.com>
 <20241113134908.GB402105@pauld.westford.csb>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241113134908.GB402105@pauld.westford.csb>

Hi Phil,

On 13/11/24 08:49, Phil Auld wrote:
> 
> Hi Juri,
> 
> On Wed, Nov 13, 2024 at 12:57:23PM +0000 Juri Lelli wrote:
> > For hotplug operations, DEADLINE needs to check that there is still enough
> > bandwidth left after removing the CPU that is going offline. We however
> > fail to do so currently.
> > 
> > Restore the correct behavior by restructuring dl_bw_manage() a bit, so
> > that overflow conditions (not enough bandwidth left) are properly
> > checked. Also account for dl_server bandwidth, i.e. discount such
> > bandwidht in the calculation since NORMAL tasks will be anyway moved
> 
> "bandwidth"  :)

Grrrr. :)

> 
> 
> > away from the CPU as a result of the hotplug operation.
> >
> 
> LGTM.
> 
> Reviewed-by: Phil Auld <pauld@redhat.com>

Thanks!
Juri


