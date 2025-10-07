Return-Path: <cgroups+bounces-10578-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AA1BBC0EEE
	for <lists+cgroups@lfdr.de>; Tue, 07 Oct 2025 11:56:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4960F3AED0F
	for <lists+cgroups@lfdr.de>; Tue,  7 Oct 2025 09:56:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 812162566E9;
	Tue,  7 Oct 2025 09:55:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DQxlaQOt"
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E113B35972
	for <cgroups@vger.kernel.org>; Tue,  7 Oct 2025 09:55:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759830959; cv=none; b=YHG869SepUvwyXfWpsJKOnNpBkW9QEJ1oOdlV2IAw3JZAU0HuaUOdMuolUWBRea90KDaTh4zvf7Pu7z8yZQMTFP5vqN7kQO/3pSqtNoz4K4yMpkgVtYzeMCPd8vP5vF2+UUD73fTWTeWATE5TVGc+KCmPlJic1tpGTCcIMJIPE0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759830959; c=relaxed/simple;
	bh=k2gXPRmtd1TD4nz3Ql3EKl6sRy1fMt/woCrNSVaMfoY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iA4th0V2M5HMhiuTCjutYqAo+h46K6PPD0K/DqqORSCSSOcuIVEg3moR2ttIN835lcZOnlg5Y3b9yjR1Ink0/M/O2iJX8tIz04PoOEZc8CfhltSopdDgTS3HXx8Y5TU3m36dfQS2MvtmbvMB7zg3plU8Qw8RgqASTfvD1xoL7Vw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DQxlaQOt; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1759830957;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Olcvv+e5CTouoj30ORBeriv/rIyq1XcOKkYrvtcS0WA=;
	b=DQxlaQOt6yGeLoHI4FJFLegYtMFZMZjpnn+u7uvz/FxP6ZAvk+WPqbrDXcdZoAiA/b3hue
	bvVJkZY5unfeXjPlZ7uCnHphUa9KfQFZ4AOxm4qd1nxqySnKfBPnZIR9b7lq3JeWZPeX2n
	zccguwia1cBnKRyUkTLdjT2WYBH1zmA=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-360-q9B-eXP3OE2rpLp2S1uAVA-1; Tue, 07 Oct 2025 05:55:55 -0400
X-MC-Unique: q9B-eXP3OE2rpLp2S1uAVA-1
X-Mimecast-MFC-AGG-ID: q9B-eXP3OE2rpLp2S1uAVA_1759830955
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-40cfb98eddbso2898200f8f.0
        for <cgroups@vger.kernel.org>; Tue, 07 Oct 2025 02:55:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759830955; x=1760435755;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Olcvv+e5CTouoj30ORBeriv/rIyq1XcOKkYrvtcS0WA=;
        b=Ej/sBV1n3At78MvyPPAlorBvrHB4eFF3xrRo4M5kyn3y4NYoW4bMvyDhXD7l3BZ9Md
         eA5zv0gcOc5rkQYAI0lsSwaO+KvARCEyufaiXkyBKnj5PiIAdgiaFBOq4Gzaa7q8gSY9
         /cxQVmqYvJcf7eqCohYzQRNbqQLqYQotRVUS91/RmYHBpjfuLhhYAtBJIxKzE1KJnoJL
         tBpEoF+XX6/g6pp9u9TOKL6jljV+ffY2ihU+o+xJ4Nm5kj8doq8mKzr0Ma7rha2oWmJr
         2wzEMo15t7Bv5CaOAVqcGUWLK5yB6E66l89Z4ENay84NFHFlIMO8Z+g8IZq0VoCaODmq
         Foyw==
X-Forwarded-Encrypted: i=1; AJvYcCVKWbF4xYF9M6aYfsQTgnZSTl5WvY2Z29lWIwCik3FYhktUBR7z6c6LSuvrXc68F1TUKUrLlxuL@vger.kernel.org
X-Gm-Message-State: AOJu0Yys2zltTuvfHjrejgaQEmTwA+mc1XwEbz6oywkf9k3BEFISpAfZ
	Wotcr2rGhpZ17EOsuvBY3RQiri4wtEsVuPquZupqKF2/2qmcMt+HJXKFzZhW7WEpvL0fVytfRF3
	Fj7yweA9yCTlOm+s5NaOdk+ExdVzypkf3PxNgt00bQqmPDdrsoVotMePm7s4=
X-Gm-Gg: ASbGncs6nioh2nn8oPmouhqmHrFcWrC0jPnAZ8BO2qqWKyxEnARTrAb3lqhDf8pxcAq
	vg5qNXRVqpqtbdIbtA3xVilZP7m+XI9YX1XnRs6Aqwo6S+Z4XW9yRJYJLSPVdrZLZcve5iLwTUr
	1RQsRYIVcCS24AYRIQlSg22o65D2OxgrfZLY/ObY9FVEnlk+kDuLXMXObEyTaUFuWJgP5iMoOf+
	yuhW1QePN4MfaA4BEzq0u+/VWA/VHyf5PXdrR/KWm8LZLrt3WkZb6Zkx1ibPHwad9gfgOAQSHP4
	5gT02riJOrwSsbOxOlx7h4jeJkP0Z2LBwf+e/sV9zlnSXqZSIl4eCgDfQB1yhk5TLrUa9H+8r4l
	uRw==
X-Received: by 2002:a05:600c:6a07:b0:46e:74bb:6bd with SMTP id 5b1f17b1804b1-46fa2952c89mr13517215e9.4.1759830954652;
        Tue, 07 Oct 2025 02:55:54 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF4OXSeLV/Yz7tujxNUfJFKucFJb4UstVFyNXz/DqV4md0An1W/DljziOCxTIGE8WujReEeTg==
X-Received: by 2002:a05:600c:6a07:b0:46e:74bb:6bd with SMTP id 5b1f17b1804b1-46fa2952c89mr13517065e9.4.1759830954210;
        Tue, 07 Oct 2025 02:55:54 -0700 (PDT)
Received: from jlelli-thinkpadt14gen4.remote.csb ([151.29.135.152])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-46fa39f3d7asm13615125e9.2.2025.10.07.02.55.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Oct 2025 02:55:53 -0700 (PDT)
Date: Tue, 7 Oct 2025 11:55:51 +0200
From: Juri Lelli <juri.lelli@redhat.com>
To: Peter Zijlstra <peterz@infradead.org>
Cc: tj@kernel.org, linux-kernel@vger.kernel.org, mingo@kernel.org,
	vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
	rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
	vschneid@redhat.com, longman@redhat.com, hannes@cmpxchg.org,
	mkoutny@suse.com, void@manifault.com, arighi@nvidia.com,
	changwoo@igalia.com, cgroups@vger.kernel.org,
	sched-ext@lists.linux.dev, liuwenfang@honor.com, tglx@linutronix.de
Subject: Re: [PATCH 00/12] sched: Cleanup the change-pattern and related
 locking
Message-ID: <aOTjp9z3MNqTQrpD@jlelli-thinkpadt14gen4.remote.csb>
References: <20251006104402.946760805@infradead.org>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251006104402.946760805@infradead.org>

Hi Peter,

On 06/10/25 12:44, Peter Zijlstra wrote:
> 
> Hi,
> 
> There here patches clean up the scheduler 'change' pattern and related locking
> some. They are the less controversial bit of some proposed sched_ext changes
> and stand on their own.
> 
> I would like to queue them into sched/core after the merge window.

The set looks good to me.

Reviewed-by: Juri Lelli <juri.lelli@redhat.com>

For the DEADLINE bits also

Acked-by: Juri Lelli <juri.lelli@redhat.com>

Best,
Juri


