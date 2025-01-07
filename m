Return-Path: <cgroups+bounces-6065-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A65AA04A2E
	for <lists+cgroups@lfdr.de>; Tue,  7 Jan 2025 20:28:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EB4F81888596
	for <lists+cgroups@lfdr.de>; Tue,  7 Jan 2025 19:28:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 713D21F540C;
	Tue,  7 Jan 2025 19:28:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="Go4UYw0r"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4B211F2C35
	for <cgroups@vger.kernel.org>; Tue,  7 Jan 2025 19:28:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736278102; cv=none; b=YrEP84ANfOd/+BMSkZ06Qx2dgyGXvIpOQTtypIWwZUYy9neEVte3c3qN6t6NDK8DYfTQEk9fGn4MeDY+zLVvPDmBwwVgMD8EedL7+bK6MBSKhbPnZ5DQCUi8h0rH8FXlHh2FxcuUYdRlzW6m4fGjy3gzn5+NsukfJegquIztjCA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736278102; c=relaxed/simple;
	bh=a6NTrjsZtYkDi7A99cHhKL3n5v9L9eTr1LxQItYebcQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JDZxbeXdl2V3r5P8ZgXnve+DK7ZyqqP2ErewLZAaoXeGv8coViEAycFGXR9YaCd5WDVgebUG137uDRyMCrc06Yh0uimls3FqNDsXvC1rLrKmiLDU0crQLMEvwMU4yP2z4OxL2ZZkz4SkjgMBthQZ50SOPCRgrzjb94aUwZYQIvE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=Go4UYw0r; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-3862d16b4f5so83257f8f.0
        for <cgroups@vger.kernel.org>; Tue, 07 Jan 2025 11:28:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1736278097; x=1736882897; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=a6NTrjsZtYkDi7A99cHhKL3n5v9L9eTr1LxQItYebcQ=;
        b=Go4UYw0rlzsJqY+rnTUIz/ZDbn04yS6Kuve8KolT4dqe7NsfZPlm1ZhlPvXav6IQfx
         8aoAWToKnRZHQi0+rJ3llHckS57mnM00t7LKDi9SYI1L5HDOxYw7uSwOhtnT7bKr8yQ/
         +GsnSp9Rts2MohRufS0ePOvK+pFGuQeXjvHK60C67dhjM0Inn2VoqaYJ5zo/yZ39w19Z
         cRCNOa3ft4KIPIzlwFyzntBGadkNGRF+mQmOi1ne+9cGxhXLkpAUabueQbWmdZG4AzUh
         ULCjNcHxuBTxkgf+zdO1+Ij9v8SoER16A4mGWOuovEszClBmgCPQFiYqY3YX08cO94AP
         Si1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736278097; x=1736882897;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=a6NTrjsZtYkDi7A99cHhKL3n5v9L9eTr1LxQItYebcQ=;
        b=DqMwoBxNqg9+z/SV4nRmlxISTGdi4L07kFuAzrQi2gGr3mJlRNU3LD+XNQ5hTfktAr
         rTGbpQyipvnjGID48fW5YyclYll2Pa8lWP0kn4+U3wiFc/z/GtZ/5/7lro1ZA8zGr2Ha
         EnBEg4nCHP/PBhUngNkGOtJOwgjJ4BDmkSwSQKJl943wMdfObFdLk+et+FlMizxLTDav
         I3nsOLBDG/1LHuxRLpkIq8a8dn6G/EjbwXOVofirDMwrgdGBBVOZ0drsomcr/jATkwAi
         yUYh6cd6kIsewBeuDPU61EfgVEyz4WlP+MK6aW2CzjAQTfLZdcjxUClpqttG2HkBh3Dx
         8U5w==
X-Gm-Message-State: AOJu0YwLGpVuFuFUN1ZFyxoqtykx8GlwpsohpiKtthrVPX0kE8U38qZW
	DC7aR3BFazr2bdeS/g5oLep2iyBznw66UCRrVSYbj4GuvoB3jaba9pVOXwANBLMoVgKux9TSt3G
	q
X-Gm-Gg: ASbGncv/5LnBpL6MsPZqg9yhK/LD6ZJKCb3krowMuZml8vnZ/mLCkY9Nt+p7aKjs69E
	imeN0KcaSw9IxRBCdtuCJ9XC9rk39cPf7YjrA0auNLfEXW1LH/6OcSNhSrRYrSgvsAW9GLi8G1c
	pyP194euw1496Lke6XboyHVUYPfRhi3AkgkE2tmA/DjU7+6rUJ4GiH/jjsC7hCiBgJmaNrUgqPw
	P+VJeak6xXv+s9Elbf3peHDlNzcxwErV1ZU3Ilb0q7nXYCTYGsR7w/WRqo=
X-Google-Smtp-Source: AGHT+IE7hD8dHvbyqIEpu/gNbPT3YTtU0RU1ZIC9FBseC/3y+GRMUF+v2BWTfWImbqoW0IKZhjOqgA==
X-Received: by 2002:a5d:47c3:0:b0:385:df17:2148 with SMTP id ffacd0b85a97d-38a7923b75dmr3694371f8f.20.1736278097185;
        Tue, 07 Jan 2025 11:28:17 -0800 (PST)
Received: from blackdock.suse.cz ([193.86.92.181])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4366a093cbfsm582993495e9.22.2025.01.07.11.28.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jan 2025 11:28:16 -0800 (PST)
Date: Tue, 7 Jan 2025 20:28:15 +0100
From: Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
To: cgroups@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, 
	Juri Lelli <juri.lelli@redhat.com>, Vincent Guittot <vincent.guittot@linaro.org>, 
	Dietmar Eggemann <dietmar.eggemann@arm.com>, Steven Rostedt <rostedt@goodmis.org>, 
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>, 
	Valentin Schneider <vschneid@redhat.com>, Frederic Weisbecker <fweisbecker@suse.com>
Subject: Re: [RFC PATCH 0/9] Add kernel cmdline option for rt_group_sched
Message-ID: <sjkkkxmtsf3h3d3e4ah26rhzl3tp26i5nohfunyf4redca43cj@ezwa4qnho4fe>
References: <20241216201305.19761-1-mkoutny@suse.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241216201305.19761-1-mkoutny@suse.com>

On Mon, Dec 16, 2024 at 09:12:56PM +0100, Michal Koutný <mkoutny@suse.com> wrote:
> The series is organized as follows:

(I saw no replies, this may have slipped through the turn of the year
period.)

> RFC notes:

So I wonder if there any initial comments on this change.

Thanks,
Michal

