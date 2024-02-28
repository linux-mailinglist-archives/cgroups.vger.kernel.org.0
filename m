Return-Path: <cgroups+bounces-1902-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5872F86B6AC
	for <lists+cgroups@lfdr.de>; Wed, 28 Feb 2024 19:04:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 874121C23A0E
	for <lists+cgroups@lfdr.de>; Wed, 28 Feb 2024 18:04:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 499A479B78;
	Wed, 28 Feb 2024 18:04:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YcWhWXeB"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-ot1-f51.google.com (mail-ot1-f51.google.com [209.85.210.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D21179B6F;
	Wed, 28 Feb 2024 18:04:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709143482; cv=none; b=mGC807GGivy2igt0+JX5WmC5sARyI7gdEaF+Nha2LdQMFFNX7o4b+PQH+FrRwryAAoOYT0CdlGfjrfyBBd0Q9CJf6WFhwACyvvw3nRga3N++Lt7Ih9E6oOoN+xruKkhTWYDBD37pl3qo8KbusVdhq0t2FWJGH6+szpmLuASXtQk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709143482; c=relaxed/simple;
	bh=2saQyttqJVlWOJlVQvafr/wEIw32lUq4JZ3sQbMUNME=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=O/P47W4i8B3YeBdMkOGZPD8yvaduLTeedlmtgKk695Gw2ISa5qZxVtFQgJKAm2+NpmoykVyo28FyATVpyKI9yRnASJEk6OTOGrj96UTfVkNNBx9eIiG7H0x0C0uTv7ZudcwW0HD4q9aur9+bj7DE1FjZkFaAtJUwJA+SJE2Q0Fk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YcWhWXeB; arc=none smtp.client-ip=209.85.210.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f51.google.com with SMTP id 46e09a7af769-6e4899fa7f1so2637895a34.0;
        Wed, 28 Feb 2024 10:04:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709143479; x=1709748279; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UG3WvQ8ltseTFttb/QP2/XnUmPp7yAiGiTL4c+bf3ss=;
        b=YcWhWXeBgDQsv0dC5ZsDBlV4ZB9b0JRekHXoeIMi7UriKqsXoIAG0twhmgZmFgp1GK
         /oIZORaRw1gUSHQYYjVV2KU/Mf5EpD6n3zXhxdJu82ZuDZDZTjv33v8sreKy8UMvrrEa
         iabuSpPGnGuBkPtiJ9PUqS0dD5zpDyTY4wvHUwLjrAaDXWj58f4vhRaoqgav9Pvf97tf
         i3yK+nPZ3gEaKY0GkLzg/21fCSIbnmd/MeN0rOaxYngN3j18tuB+6HTxHG+wPdYefV8D
         WbjjWp/GAhybcqk+V9LOWJIOpnlYKxmPJAPOTcIS9mj7N+x37JJCE79ZsAXmv61184Q1
         mSxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709143479; x=1709748279;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UG3WvQ8ltseTFttb/QP2/XnUmPp7yAiGiTL4c+bf3ss=;
        b=i2kG6RdPQ3qgHd4yvGdZQMFS3piDEhi0Ue9od+7324l5EVBqihSzoDUkelqzuTvFJB
         PxhAgd0eIOJcTcC1qvnvKQEgM7AYBlQ9yY64ZWADfzlxH5+cxAsaH7ieP0TEI5U75ILU
         sIyWrNc0dpajc2tKq0xwUkOVhZz9YlvEDZrwtIX47uwhctU4Ea9ErD/dmnS5rdIh/Iil
         O4usH9Yi9T4rB5wlMjTTRLlkPHbH0A8l/cmipUc+5HQNkClNOX9CyfOYNtMGhssJ+iPl
         ZcUVuG/4FZv1OpPAF+Ch8SvgHFsj4ZvoPD5TX5CtZO2OlU9LggGCWq32klv4Yncgz86M
         VVBw==
X-Forwarded-Encrypted: i=1; AJvYcCWTS25WYuYXx7Tvu8UcxnOapNUbwsDu+qC46oFKiBl5U+qGzplQIOOE3QGEZBebgDCjLm4RglggAnhBfxPckhEALgpiTYy2sriZ2pLV8wopSMGpks8XATQD5l4bFo2SC+dua5cASw==
X-Gm-Message-State: AOJu0YxJLYiQ4m4TpbECT5DYUMj9ZCOH+YywDntfhoXZm3iBbYltUOsS
	PuGqBFzMw4wr0lVGqTAE3bbcyhQd3eAyqvj2inmOEscTfaoZY+Mb
X-Google-Smtp-Source: AGHT+IHCQZEUOvop47RwRMRoUQ069578uWjOmBVvEDIDp+2RjKizzYGbaRsQvLLigdWAUll/iYJIQw==
X-Received: by 2002:a05:6830:1d84:b0:6e4:a6be:8ba8 with SMTP id y4-20020a0568301d8400b006e4a6be8ba8mr393859oti.7.1709143479392;
        Wed, 28 Feb 2024 10:04:39 -0800 (PST)
Received: from localhost ([2620:10d:c090:400::5:8305])
        by smtp.gmail.com with ESMTPSA id r10-20020a056a00216a00b006e4c2043d9csm1885036pff.35.2024.02.28.10.04.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Feb 2024 10:04:39 -0800 (PST)
Sender: Tejun Heo <htejun@gmail.com>
Date: Wed, 28 Feb 2024 08:04:37 -1000
From: Tejun Heo <tj@kernel.org>
To: Waiman Long <longman@redhat.com>
Cc: Zefan Li <lizefan.x@bytedance.com>,
	Johannes Weiner <hannes@cmpxchg.org>, cgroups@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Mirsad Todorovac <mirsad.todorovac@alu.hr>
Subject: Re: [PATCH] cgroup/cpuset: Fix a memory leak in
 update_exclusive_cpumask()
Message-ID: <Zd91tagUX3EZCINk@slm.duckdns.org>
References: <20240228005801.429847-1-longman@redhat.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240228005801.429847-1-longman@redhat.com>

Hello,

On Tue, Feb 27, 2024 at 07:58:01PM -0500, Waiman Long wrote:
> Fix a possible memory leak in update_exclusive_cpumask() by moving the
> alloc_cpumasks() down after the validate_change() check which can fail
> and still before the temporary cpumasks are needed.
> 
> Fixes: e2ffe502ba45 ("cgroup/cpuset: Add cpuset.cpus.exclusive for v2")
> Reported-by: Mirsad Todorovac <mirsad.todorovac@alu.hr>
> Closes: https://lore.kernel.org/lkml/14915689-27a3-4cd8-80d2-9c30d0c768b6@alu.unizg.hr
> Signed-off-by: Waiman Long <longman@redhat.com>

Applied to cgroup/for-6.8-fixes with stable cc'd. Depending on when v6.9
gets cut, this might go in together with for-6.9 during rc1.

Thanks.

-- 
tejun

