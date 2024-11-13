Return-Path: <cgroups+bounces-5539-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 45C199C790B
	for <lists+cgroups@lfdr.de>; Wed, 13 Nov 2024 17:41:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0B6F92858AE
	for <lists+cgroups@lfdr.de>; Wed, 13 Nov 2024 16:41:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 188CC1DF272;
	Wed, 13 Nov 2024 16:41:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PBYZ9iqA"
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C120167296
	for <cgroups@vger.kernel.org>; Wed, 13 Nov 2024 16:40:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731516059; cv=none; b=m8IRZkRhbcXNUjtGNw9LkxuMlyJv6bdF9HbTmEKYNJ04idB0D0sI+rkrLTNqyJdoRHNK/428kkZxMg05LVcleR4yJiRWqP8BCcefI0S4rBPn94Z34zNWEhOjCO93e0cByR1Ko1b4tiBVMU6j/zT5Z2fInLJG5yOEF5s/a/xF4Bo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731516059; c=relaxed/simple;
	bh=0Q7kh3jskOrlE/pCHXTHHbNGNC4794SLr5kSLYmIDjU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CNrEA9knxKLe/+b0fk7+0IbirSimEO5OgGy+inRZ2zq1+t5ludYIMrd2ijHmI91J6b8e2X7wqqXk/yeoCwKPk+uWAj2X8jJeaCTKzJ25+NhDvQDG1M2sGsO5G+1RMkHTTA95S658k/WIrJtkzgbcP4Jg3IR1T028AHbp0vonCNY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PBYZ9iqA; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1731516057;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=0Q7kh3jskOrlE/pCHXTHHbNGNC4794SLr5kSLYmIDjU=;
	b=PBYZ9iqAgsqHvcFng8IDu09dvFpC52hqi65F+49mKrcgyq593jTQ1iDId2W4PZUadjl3/r
	rZJVzVJa8al8IS+ZSMC5KT3yEuBm7HcnHTHF/15Fi+n7ZsULbotf4dgVUtdqFUd7Y0XGza
	uVuqDZ0X0rx+m9wu7M0k59uqy/3yMyU=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-213-5SL2-3a9Nn-iwywEum3-PQ-1; Wed, 13 Nov 2024 11:40:56 -0500
X-MC-Unique: 5SL2-3a9Nn-iwywEum3-PQ-1
X-Mimecast-MFC-AGG-ID: 5SL2-3a9Nn-iwywEum3-PQ
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-4314c6ca114so54050165e9.1
        for <cgroups@vger.kernel.org>; Wed, 13 Nov 2024 08:40:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731516054; x=1732120854;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0Q7kh3jskOrlE/pCHXTHHbNGNC4794SLr5kSLYmIDjU=;
        b=Sm6HGXjTO/+EKUO2nc2DUE9zUaGqLfGjjikp3WlpLKBdsPb80r+DhXE2anS0uiPV3E
         2duKJ6vwClxWwKD54ivIYxrks2HP4bls+oTyL3hBfYWXKl+aE+Pgb5WdXjCtwWcK7Phu
         7tf9bkiqlNJ4StF9TOObCuvtIQvI8pSz/KNExe44esX0v3LhelgGlCTplav7aBWLdyt7
         3ue7v/tpkRFY1K63KVyl/Kc+Ld8k1qps0JeI4SigjSK0McnkssJueiLKFxR0lcjb404D
         0xeasDjFrL7+DCcMFi9wYa6uGGDTYI2KH3EUxDYbM0IjfeTQqOpoz6OVqQJRED1fDitl
         ADeg==
X-Forwarded-Encrypted: i=1; AJvYcCXHzEq6L3aKhHJgq/6nkdFgqHJ+5RzeOsMwwMGKNRRaSSYeReBWvwcwukB/TEDPcceLglz6SQWD@vger.kernel.org
X-Gm-Message-State: AOJu0YwZsDiD2+hINRVtpb/a83QLoSklRI4AtByKT8snrT5UFJ8MUMyz
	VF7ghSkeC2Nf3XXNtoovzPriYVNtCJZkN2IdPBp2IvMAss/Gf9w59+qOtYp6MGAnk7gMd7ga2RR
	VZeRpp+c9MgyBKDqvfelhL6NJf2AWhcfyxxvDSBjbHQ0UW1a3zzXa8pU=
X-Received: by 2002:a05:600c:3d05:b0:431:7c78:b885 with SMTP id 5b1f17b1804b1-432d4aaa11emr34935245e9.4.1731516053767;
        Wed, 13 Nov 2024 08:40:53 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHFQ7t1MLzge6g1NzYJfsmBrzfLmhfNgwB0NjnWV3vCzt5pLtHkQ7sgmX7XneDTPBcDj64hAw==
X-Received: by 2002:a05:600c:3d05:b0:431:7c78:b885 with SMTP id 5b1f17b1804b1-432d4aaa11emr34934985e9.4.1731516053473;
        Wed, 13 Nov 2024 08:40:53 -0800 (PST)
Received: from jlelli-thinkpadt14gen4.remote.csb (host-80-47-4-194.as13285.net. [80.47.4.194])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-432d5557332sm29571735e9.43.2024.11.13.08.40.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Nov 2024 08:40:52 -0800 (PST)
Date: Wed, 13 Nov 2024 16:40:49 +0000
From: Juri Lelli <juri.lelli@redhat.com>
To: Waiman Long <llong@redhat.com>
Cc: Tejun Heo <tj@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>,
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
Message-ID: <ZzTWkZJktDMlwQEW@jlelli-thinkpadt14gen4.remote.csb>
References: <20241113125724.450249-1-juri.lelli@redhat.com>
 <20241113125724.450249-3-juri.lelli@redhat.com>
 <8e55c640-c931-4b9c-a501-c5b0a654a420@redhat.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8e55c640-c931-4b9c-a501-c5b0a654a420@redhat.com>

On 13/11/24 11:06, Waiman Long wrote:

...

> This part can still cause a failure in one of test cases in my cpuset
> partition test script. In this particular case, the CPU to be offlined is an
> isolated CPU with scheduling disabled. As a result, total_bw is 0 and the
> __dl_overflow() test failed. Is there a way to skip the __dl_overflow() test
> for isolated CPUs? Can we use a null total_bw as a proxy for that?

Can you please share the repro script? Would like to check locally what
is going on.

Thanks!
Juri


