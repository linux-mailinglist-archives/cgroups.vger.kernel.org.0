Return-Path: <cgroups+bounces-7014-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 97D5FA5DE15
	for <lists+cgroups@lfdr.de>; Wed, 12 Mar 2025 14:33:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4818918972A5
	for <lists+cgroups@lfdr.de>; Wed, 12 Mar 2025 13:33:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BE1824EF64;
	Wed, 12 Mar 2025 13:32:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="jOsS+UWH"
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E686243376
	for <cgroups@vger.kernel.org>; Wed, 12 Mar 2025 13:32:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741786371; cv=none; b=rjUzVu+GjIxxUW1b1ySnKdr0mpaRCNOlOkJDxlfPLUd2BuaP+rw22jkmnQcQByMVyvcDikZsglCalNo2Sd7y4eyCLbwtfIp6fXnyGPq2znkAaoeCzSkF9VqxAzOfhnFQ18L2mQ/8zMWPLY2FqbDioMGdecxbq7jIsStHnNIdJfk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741786371; c=relaxed/simple;
	bh=a0HQy0k5w53qyMHQeW87mKrINhCTs1ce/60tyzHSvj4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=hw2zfpmV+wV6ibMeL8lmBS6jPJqZiK2RmuHo/q3dE2R9pH+NX9QmriPn/5W/u4Z/PBsLbbqk8vIr2EJGVRAu4l1sTt1gHtde/r905+wb9cQdMI8ZCoeWHEEKhi+ZMtb8yDmwXz2IgWJVQgosdVmZ40lti1z/zcwuD2pDe0yvWtc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=jOsS+UWH; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741786368;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=a0HQy0k5w53qyMHQeW87mKrINhCTs1ce/60tyzHSvj4=;
	b=jOsS+UWH894VYXTnbfV7KFj0elTajeFI7sq+anrLeloiBvrMIMKQXoJDTkYWBjzI2rmsVA
	+2y4Hye9DECQqx3TAkSjhh+BIFcR/6guPAqqeJ0xkSt/d6l1qJgW8M/lhf+tO9gahHHC0T
	ha3NUn8BHt4L0RTPRyV6W7ZTcT4Gyng=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-317-1FPo8l9bOey6XbSFZodOFA-1; Wed, 12 Mar 2025 09:32:43 -0400
X-MC-Unique: 1FPo8l9bOey6XbSFZodOFA-1
X-Mimecast-MFC-AGG-ID: 1FPo8l9bOey6XbSFZodOFA_1741786362
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-3912fc9861cso2739286f8f.1
        for <cgroups@vger.kernel.org>; Wed, 12 Mar 2025 06:32:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741786362; x=1742391162;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=a0HQy0k5w53qyMHQeW87mKrINhCTs1ce/60tyzHSvj4=;
        b=t6ZxxL6mHxihT++KmqobohPTM5TLhfuYQ8zhLza/88fYzeZo9gu9JL/SSwAct1Xs2B
         TpLSpKJLXRJuvJApGhKwcp2KZf/FJjhPgwYo9hoai37e3wwjLNNIGJod4gZI7f4tsATz
         3a/zKYHa813AmgPQbRj6zYy9rLQXSglZfnWHM9GIdHjLt8OKiPaMvxXsazR7oaYfaYM7
         IPNpDOtrvHpp1qnW8BlF6B//CVx6zVGeBh0ypfXaJ2zG+Y7dmn/dJ2S5fKY9Fbz3cs6e
         JxtYymxkuRpG+K0DGNva3lmQjjLhrGGGcPXWR09I1pgucYnBzRe3OZ2OpeDqWqJxonKq
         i6pw==
X-Forwarded-Encrypted: i=1; AJvYcCV+Af07OXtONHAqH2c0VfJLXujZL4AU+ywxApsMjwzr6S0M6vgrqP62vB+lhpxCu1qI/ri2ebQZ@vger.kernel.org
X-Gm-Message-State: AOJu0YwRHsrFxfliZpSEMYUwUXrKOsRu95w+7YRp64sctncG/5qxFGLw
	ePKm0xVlL1p85G2pvHTF9ojsAguaso5/PagYi1ASXr27pwcyAzQnCnfCWqhH+xIv4Jcc9oxjax4
	Clg6zmq1erEPoxYpmubXCBXAvVcAp+u/wU+yDFwVeZSS9EL7W6gXvWo4=
X-Gm-Gg: ASbGnctOIJIUimcWo9sm52MsSTNB31ZCPmPyEcvpuwNEMs8DXGUDNL+DFfixoWTl91r
	bfZyiIpwCDBGIcNv0YvChjxxLiuqrjEpaJs3C4YoILysT8EU9Clkg6mek3zOT6bvAHA2ENI7/Bc
	2OFqfp88nm32w/Jq/ibHi/3u3F8JKEK81Fg6jb+/bRY0mMCnjdM6v3Qz8b7gXaRl2UexIjiXm8M
	0UqeB3WiJeXDqBlT3Lg+FDX83VpdNzQOF3gj0bAoB29ARVpr/ia2g8REthzfA6IAjVh60kcHJA3
	0WI87nOxZdYFXzXKwyYuyIaDQxX6W+ByJWmoQz0Yh6bpYxvYN7FJhOWFtQuxSz8raaRiXxpYA5V
	S
X-Received: by 2002:a05:6000:18a3:b0:391:32b1:9458 with SMTP id ffacd0b85a97d-39132d05bb7mr18256088f8f.3.1741786361769;
        Wed, 12 Mar 2025 06:32:41 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGBmYHadL05QdCXMwWJyreltC2sDc+Ii43t+J7joC9A2cXjFamelnxdyrEIk6da1YZ5loRJYQ==
X-Received: by 2002:a05:6000:18a3:b0:391:32b1:9458 with SMTP id ffacd0b85a97d-39132d05bb7mr18256073f8f.3.1741786361444;
        Wed, 12 Mar 2025 06:32:41 -0700 (PDT)
Received: from vschneid-thinkpadt14sgen2i.remote.csb (213-44-141-166.abo.bbox.fr. [213.44.141.166])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3912bee262esm20982120f8f.0.2025.03.12.06.32.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Mar 2025 06:32:40 -0700 (PDT)
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
Subject: Re: [PATCH v3 8/8] include/{topology,cpuset}: Move
 dl_rebuild_rd_accounting to cpuset.h
In-Reply-To: <Z86zp5ej0shjk-rT@jlelli-thinkpadt14gen4.remote.csb>
References: <20250310091935.22923-1-juri.lelli@redhat.com>
 <Z86zp5ej0shjk-rT@jlelli-thinkpadt14gen4.remote.csb>
Date: Wed, 12 Mar 2025 14:32:40 +0100
Message-ID: <xhsmhikoepe6f.mognet@vschneid-thinkpadt14sgen2i.remote.csb>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On 10/03/25 10:40, Juri Lelli wrote:
> dl_rebuild_rd_accounting() is defined in cpuset.c, so it makes more
> sense to move related declarations to cpuset.h.
>
> Implement the move.
>
> Suggested-by: Waiman Long <llong@redhat.com>
> Reviewed-by: Waiman Long <llong@redhat.com>
> Tested-by: Waiman Long <longman@redhat.com>
> Tested-by: Jon Hunter <jonathanh@nvidia.com>
> Signed-off-by: Juri Lelli <juri.lelli@redhat.com>

Reviewed-by: Valentin Schneider <vschneid@redhat.com>


