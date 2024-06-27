Return-Path: <cgroups+bounces-3423-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ACD6191B11B
	for <lists+cgroups@lfdr.de>; Thu, 27 Jun 2024 22:58:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 672DC2814AC
	for <lists+cgroups@lfdr.de>; Thu, 27 Jun 2024 20:58:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5155919E827;
	Thu, 27 Jun 2024 20:58:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QWyWhPIy"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B40AA14D6EB
	for <cgroups@vger.kernel.org>; Thu, 27 Jun 2024 20:58:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719521920; cv=none; b=LiSv8OBYBnc/43gZTLt7wrQPDHnkRX6R7aKnlh3ryrOg06JX9AWJaUqS8QuxpHnXauIuYfhg7VkjeAj2AHsa0pUgLmMU3+U94ocZhkWUCkmg0O4vfo1Ch638vQzG26uwLyXSQo47VnvYGXWnT2chbyFn5dh0lmhH9xZF8LJRTPg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719521920; c=relaxed/simple;
	bh=tCM8gT6NzEjkLpHDmWG4i+ch+T3fEfyNltRRgCapcis=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=amPW4JI/Ro0TthnRMEFcwRWZj/Ddy8gmybV6ibhYFYrouMhyUhJLwXUPdeIWDhC+YgS54UvlP8kh6gh+Ht0rYgO03/0cTxFFFv3HBcTKJKbUaf1zsgwCeT//4tS+SbMlbnLvdrYyVsBJ3UNIep0wGJ2BWFGyc6zsZNIT5fKKeoM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QWyWhPIy; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-1f70c457823so57356135ad.3
        for <cgroups@vger.kernel.org>; Thu, 27 Jun 2024 13:58:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719521918; x=1720126718; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/uQJvg/MADuVbWccuZlM3rIObs0+4ZOEbLRDdDNvRko=;
        b=QWyWhPIy1i73ExOunCobxHREDNNgvB7aD07JQ1cnO7mm3BUzyv5YwXJaH7z6MiiJOR
         9PM5arRFuoG+5lZmrhMEuITKI8H8sJKvfIss1h3uWuciRBYWrb9soVCfbVzFPjkLDwf0
         zqF3LjPH9IjPo8HGPpvaPUvByvjUW+SPteDRZOsFUqW+TGLc+hszhwyu2HEdnSQ8de4k
         AHhpN7P4wc1NDiZLo6WfFnsmI4XXQ2YBzg7GG6TD0Pod8SeeGpw6I63PHsHGE/L8O1MO
         K+0f+A4af8nJCqVa72qpudp5sgE5gZ2ywIj9MaBp+X005sQnyc1E9o4HLE8Wl8TuPeKO
         tPoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719521918; x=1720126718;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/uQJvg/MADuVbWccuZlM3rIObs0+4ZOEbLRDdDNvRko=;
        b=LRHa2nLA7zEWx8RPPiwrFxkqvein6+eMnsX6o+fKs/06Rr914jfIsqZFOsdhU4bgUZ
         xHUJL2bkhl8WNm6pfP2JHvhL5+F/OuLv4JjK+OH079U8aQhvpytd5HcThUUI4aDtw7RT
         E17PfdulnNoZZW5FRAJpc2hwQ/rpyktUXZvYv6e/ZJstkezs8xDSgB/f6HMCOZaSnER2
         4OD7pgyhWFGBEhMTDz1lSU5Dgv60rVZCfPblZUlPh9v0z5wNVZ57E68DxpsYMUscEj38
         LJj7/Iu61ADTD44GzMZ9dhpNWnblyFI6FDcNIdjwWGGDzajg2VB/3+2N8GsDnvX5mSna
         HkzQ==
X-Gm-Message-State: AOJu0YxRoGZEFHTxConVKNUykDFeHmk3T0rhaXsOgXeoyeh2UwVYIRFl
	3ynl864IvDpjyEBbbZSDPwdQqRwZH6kIYdTK8OD0wTA2R20SzMSL
X-Google-Smtp-Source: AGHT+IHzhutytml9lZ8ubKptuOSGAMWYGiEZ06sATCTbYNeYXuckClWpXcmYOHZEN9n+48uLa9FtOw==
X-Received: by 2002:a17:902:db03:b0:1fa:18c3:2796 with SMTP id d9443c01a7336-1fa23ecdcaamr146573135ad.25.1719521917903;
        Thu, 27 Jun 2024 13:58:37 -0700 (PDT)
Received: from localhost (dhcp-141-239-159-203.hawaiiantel.net. [141.239.159.203])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fac10c8b34sm2028105ad.35.2024.06.27.13.58.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Jun 2024 13:58:37 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date: Thu, 27 Jun 2024 10:58:36 -1000
From: Tejun Heo <tj@kernel.org>
To: Michael Fitz-Payne <fitzy@discourse.org>
Cc: cgroups@vger.kernel.org, Johannes Weiner <hannes@cmpxchg.org>
Subject: Re: unexpected CPU pressure measurements when applying cpu.max
 control
Message-ID: <Zn3SfIDbZhiySAOQ@slm.duckdns.org>
References: <d13273c1-533b-46b4-a3ab-25927a8b334e@discourse.org>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d13273c1-533b-46b4-a3ab-25927a8b334e@discourse.org>

(cc'ing Johannes who knows PSI a lot better than I do)

Hello, Michael.

On Wed, Jun 26, 2024 at 09:53:55AM +1000, Michael Fitz-Payne wrote:
> In short, processes executing within a CPU-limited cgroup are contributing
> to the system-wide CPU pressure measurement. This results in misleading data
> that points toward system CPU contention, when no system-wide contention
> exists.

This is in line with how PSI aggregation is defined for other resources. It
doesn't care why the pressure condition exists. e.g. If system.slice is the
only runnable top level cgroup and it's thrashing severely due to
memory.high, the system level metrics will be reporting full memory
pressure.

...
> I've compared these tests on a 5.10.0 system as well as 6.8.9 (above).
> 
> There are two differences I can see:
> 
> - On 5.10 the 'full' line is not present in either the cgroup cpu.pressure
> interface or the kernel /proc/pressure/cpu interface. I'm assuming this was
> added in a newer kernel at some point.

Yes, because full pressures are defined in terms of CPU cycles that couldn't
be consumed due to lack of the resource, initially, we didn't have
definition for CPU full pressure. Later, we used that for measuring cpu.max
throttling. It makes some sense but can also be argued that it's not quite
the same thing.

> - On 6.8.9 the 'full' line in the cgroup cpu.pressure interface appears to
> provide accurate data based on this simple test.
> 
> As we know, the kernel 'full' measurement is undefined.

How do you mean?

> In either case, the kernel PSI interface is the canonical source from which
> we want to read the measurements for warning us of CPU contention on our
> fleet of machines. Due to this unexpected accounting, the values may be
> misleading.
> 
> Frankly, I'm not sure of what the behaviour should be. I can see the
> argument that the current value is correct, given the definition is 'some'
> tasks are waiting on CPU.

This sounds more like you want to measure local (non-hierarchical) pressure.
Maybe that makes sense although I'm not sure whether this can be defined
neatly.

Thanks.

-- 
tejun

