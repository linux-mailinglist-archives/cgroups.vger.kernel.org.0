Return-Path: <cgroups+bounces-7012-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DBCF2A5DE0F
	for <lists+cgroups@lfdr.de>; Wed, 12 Mar 2025 14:33:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 28D0217182C
	for <lists+cgroups@lfdr.de>; Wed, 12 Mar 2025 13:33:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AA3424CEE4;
	Wed, 12 Mar 2025 13:32:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="i+zbBM1P"
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED76623F422
	for <cgroups@vger.kernel.org>; Wed, 12 Mar 2025 13:32:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741786358; cv=none; b=LpgMzWpZwLkM8ABNfl2Vl0P427J4K0tiuVY7cIEIXNokUqkQVC1b1MpiMqwByrUrHPLhNY+ZbkmN+LdypQggP6G8bLXxtiBHXu0ISr7LBDSPgYXozhArR7x7RByffMUy+ccYEZqt7uqVZ8ChHLDjhRns2OQ+HNvDChzuc++OJiE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741786358; c=relaxed/simple;
	bh=pMBnQB/WptlgARfKUKxfFhODgPcRfYP9RORJ9mLu3/4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=jJDsADJU+GAqESwUtuwn1vx1pNUJreFnHclal/ieVaOx6uviCQC1uFDJhC4gvsarJUCrl3PQeXKoJU01p+PmqCABS/vEvxHC6nPR8lQLGK1/jPuRzSjY5TaMiySltljkfVSnNYrjnU06hSo5KDkcHxd8zvp/U4ptRjuIOLEVCBE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=i+zbBM1P; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741786356;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=pMBnQB/WptlgARfKUKxfFhODgPcRfYP9RORJ9mLu3/4=;
	b=i+zbBM1PaVsVn9URvckRrFP1hi1wC4VUieDkKfLvoRbENyXgsd09Yh814nIb4Lum/ddUH6
	q8Bnyv6KzYN5t260GwiEbRlL+weWCuAJbisjBLyA9ljPYBvW4Zd74eE1gE7UWZXQfTL3tA
	CltksylH2DbNa2EXvHdCs5ZOazkhRGo=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-650-lFM32CFvNB-ZgC4TZd3XhA-1; Wed, 12 Mar 2025 09:32:34 -0400
X-MC-Unique: lFM32CFvNB-ZgC4TZd3XhA-1
X-Mimecast-MFC-AGG-ID: lFM32CFvNB-ZgC4TZd3XhA_1741786354
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-43cf327e9a2so27616025e9.3
        for <cgroups@vger.kernel.org>; Wed, 12 Mar 2025 06:32:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741786353; x=1742391153;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pMBnQB/WptlgARfKUKxfFhODgPcRfYP9RORJ9mLu3/4=;
        b=B1WsRQRur8T49aaanXS5Fze0JwMU+kpUeXie/iUBGaLMd2YDeg+OPJwMQGdhVKD5qD
         W+VgN4ST3tZhA7KAlTu2fBnXfeTwuqVQ6uNCkL/os/zxU/ma/lkdl3xKMR7PvgbPnGHm
         VdeCUaMFBGwCvnKsf+IqxVLw/dd0HSsofxpZsl9nMzXLFIyBzoLIR17Fh6P0fulUqBTh
         MP7VR2+QDY6cCARwJNwu94WjB9D7wvUgczmZsTWaIYSr7b5iZQGslnD204nAtXwdLdbM
         WK0m9YSJbbxTP7LbZABh8WB3tCKLhUYFWRPYrqVxjWVdjT435dYZhmPl7CUrL42/c5X8
         IGrQ==
X-Forwarded-Encrypted: i=1; AJvYcCW47WgqtPb1qCszYmDeHoGx6S/mBxQ/sdtu7tjC+Bbh6eT/t72zAtaZRr19sX9VrPlBCUj+qoUi@vger.kernel.org
X-Gm-Message-State: AOJu0Yz4TuyiO1Du7DfGdJMWleJkpDnUCu9V23HcGZas6gr8cKxeMojN
	45kFMxE/9QfQCw/CsoIzxi2f3x8WfpIaeSIQBJ9PWKRp46TU5r/95IMYAyvlpl5PKT3e9kTqjue
	f+6JHOvCzC/rJqpqiTbicl17QWa5+byeX5knLOTAIvlraDMiy7v6/GM8=
X-Gm-Gg: ASbGncuZ5ti9zG/Hms4t+wyrQSaMubcK+koTV1R90p0O4xvIubp6gbuDrNfxBTtNW9H
	GpoOx3SOFNyuj94JWSyufRuCy/glAEB4ruQJR9idllpK/6gY4byxX7+09zWpj7MXH1Mp31rlPpv
	rCFfyLEFWezJo+xA5t7al+ooHzb+cP/tQc/DFPf1vdn2YKEiZqI4CkQgug9xk2bf/TShP4p6w12
	iaCcPDIgfh6lOPcDm9InfofUQA42MGUFcbRzvgliQPXK0QJ9/UelYOVm/8WpLDiess5b71mKV0B
	LacbeEpy0MtsTX5OI//ejetBVksk7yWqEYIEM3qrF1T7T3dmlZXlI9uSpGreO3o2EO2UBjFsxar
	e
X-Received: by 2002:a05:600c:4f14:b0:43d:7a:471f with SMTP id 5b1f17b1804b1-43d01be7e4bmr85573945e9.18.1741786353619;
        Wed, 12 Mar 2025 06:32:33 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF3ABjY0Wbyoz7mffI/6sHIGOzIiGV3f5HP6r39Oz4vaIdVFyhl7aarVfkrAHGsAg9ShJgZSQ==
X-Received: by 2002:a05:600c:4f14:b0:43d:7a:471f with SMTP id 5b1f17b1804b1-43d01be7e4bmr85573675e9.18.1741786353291;
        Wed, 12 Mar 2025 06:32:33 -0700 (PDT)
Received: from vschneid-thinkpadt14sgen2i.remote.csb (213-44-141-166.abo.bbox.fr. [213.44.141.166])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43d0a78d245sm21220905e9.28.2025.03.12.06.32.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Mar 2025 06:32:32 -0700 (PDT)
From: Valentin Schneider <vschneid@redhat.com>
To: Juri Lelli <juri.lelli@redhat.com>, linux-kernel@vger.kernel.org,
 cgroups@vger.kernel.org
Cc: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
 Vincent Guittot <vincent.guittot@linaro.org>, Dietmar Eggemann
 <dietmar.eggemann@arm.com>, Steven Rostedt <rostedt@goodmis.org>, Ben
 Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>, Waiman Long
 <longman@redhat.com>, Tejun Heo <tj@kernel.org>, Johannes Weiner
 <hannes@cmpxchg.org>, Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>,
 Qais Yousef
 <qyousef@layalina.io>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Swapnil Sapkal <swapnil.sapkal@amd.com>, Shrikanth Hegde
 <sshegde@linux.ibm.com>, Phil Auld <pauld@redhat.com>,
 luca.abeni@santannapisa.it, tommaso.cucinotta@santannapisa.it, Jon Hunter
 <jonathanh@nvidia.com>
Subject: Re: [PATCH v3 6/8] cgroup/cpuset: Remove
 partition_and_rebuild_sched_domains
In-Reply-To: <Z86zO_uCamVRRUqe@jlelli-thinkpadt14gen4.remote.csb>
References: <20250310091935.22923-1-juri.lelli@redhat.com>
 <Z86zO_uCamVRRUqe@jlelli-thinkpadt14gen4.remote.csb>
Date: Wed, 12 Mar 2025 14:32:31 +0100
Message-ID: <xhsmhldtape6o.mognet@vschneid-thinkpadt14sgen2i.remote.csb>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On 10/03/25 10:39, Juri Lelli wrote:
> partition_and_rebuild_sched_domains() and partition_sched_domains() are
> now equivalent.
>
> Remove the former as a nice clean up.
>
> Suggested-by: Waiman Long <llong@redhat.com>
> Reviewed-by: Waiman Long <llong@redhat.com>
> Reviewed-by: Shrikanth Hegde <sshegde@linux.ibm.com>
> Tested-by: Waiman Long <longman@redhat.com>
> Tested-by: Jon Hunter <jonathanh@nvidia.com>
> Signed-off-by: Juri Lelli <juri.lelli@redhat.com>

Reviewed-by: Valentin Schneider <vschneid@redhat.com>


