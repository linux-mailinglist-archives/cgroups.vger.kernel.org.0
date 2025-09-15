Return-Path: <cgroups+bounces-10128-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C9ED5B58633
	for <lists+cgroups@lfdr.de>; Mon, 15 Sep 2025 22:51:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7FCD64C3EC7
	for <lists+cgroups@lfdr.de>; Mon, 15 Sep 2025 20:51:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED0E32BFC9B;
	Mon, 15 Sep 2025 20:51:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="g3AZCbEA"
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C4D82BEFF6
	for <cgroups@vger.kernel.org>; Mon, 15 Sep 2025 20:51:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757969475; cv=none; b=t31ONEEFlCPDEC7IftfZS7UUWO2lLqWtl0OkuidNPQ8lQICa4/L9TQTYGaVOm4XZ0wLXPyLZlFJpO2Ce+m7gAjWzSmqx71GqbLkF/pnswZwG/gkTidu/O03iiQRgoCJyud984pM7oUBYf5DrllTbIkSCBKp6g3a2RMMjA9pVkPU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757969475; c=relaxed/simple;
	bh=gSBcW45s16hJL1h4JORD0BXMNvr3/+WDFr/c3yqwes4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YRTLaSgn+J4e2YF/IQLKvJlTnrV1yaOsZY0IgL9CVWXpl7648IWeg8lOixY0MZpDx1eZNmyiKcd4Qxg3CD48AwBnOnW8kC6gkKNA9i8p/Kvj4tBKOpuwtoB0HYw7G0frraIPMOv3mjQ3G5K7axobSWpBo/ou9XtHLbK0e2toE4Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=g3AZCbEA; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1757969472;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=GOMr9SAO3u5wgAz3CRJrisoyKwgRYko4OWapp7xVpSY=;
	b=g3AZCbEA/ccDKHhozTmQxx0t/KJvzu4INUva74z3r/zxbhChqyvma9PXOXClCu73InTEDm
	Q45y/m1/r0hNLv3vGyu3AcmT8Ot6Xn9VOBhdFucVY2lWzGspRCnst3xiBZlKBfKrHDNJEf
	ML6EH+HoXy6g4IW4rpRiYyKOnKwQt0U=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-388-OX4Af8iJOr6bMMawsOKhRA-1; Mon, 15 Sep 2025 16:51:10 -0400
X-MC-Unique: OX4Af8iJOr6bMMawsOKhRA-1
X-Mimecast-MFC-AGG-ID: OX4Af8iJOr6bMMawsOKhRA_1757969470
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-70d7c7e972eso90915656d6.3
        for <cgroups@vger.kernel.org>; Mon, 15 Sep 2025 13:51:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757969470; x=1758574270;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GOMr9SAO3u5wgAz3CRJrisoyKwgRYko4OWapp7xVpSY=;
        b=SLk6Ubej+CX7gpJU+MIjRWY+ou12UD31cW2jgfCoNvV4UVbTrUo0/GPxYwH92BsG3u
         wfA0OmW6LYAn91J1FLZmWgfcuDSuf4XfBnAklQeGRimiKC9LdE/yXD/Pm2GYZtOwue+Z
         dKUaYRp4ksPxcsg6080Zdt6bnugsRAbsX/whr2Duxqfu5Eei2m54stXNkaLBder1OXBf
         ugFacnIWD0MmdjaCZ1h/B5dYdzepv9hdHG/HKoSZoyNLAV4j0ClcOd10KM6SMUtWsYQc
         VVa6+iuelvU0pGIAlB5scWo4wPchUl9R1Iy3fy1l7+yQ+u4bL2i9qAY5ZvpaDK5+uVlc
         TaVQ==
X-Forwarded-Encrypted: i=1; AJvYcCVHDR+B5cHOuelSzqN4AeOex4ullZvbfNA4wcjAB4RTvlt8E9eul2AtWKIy11c3z3DxH34Shh+x@vger.kernel.org
X-Gm-Message-State: AOJu0YyAz5HKN4yeFEscrVdMKLloT6FNC743jipicbtBUt293yVewHKi
	wkdeqKJDdzXTWVeiMMkPB7MRSlTUEQKlh92WXp4sjFimgP3oSjGEH03Y5ba3xCBIHIIUFYpPynK
	IyXeFvPWTB3FWSRT9tDEMyEq5fefTZ2Uo/VVuWkT5YvCtyYmS2D7IZ3efuns=
X-Gm-Gg: ASbGnct+dy10tgZSJYGt9Buj8yF15JoEMuwhazweW5HXswqw2T2u3qlz+rXDlusK2aQ
	tFx0/TCDewm8O/t/EcpLh0XBCYSXegyq1IbAFo52Y0zl6rjb55CkBaBjmAzeUJCnmLnHYN6y6Uy
	2MMi+IuIjxtR7tclgbK6liBJCvW/VQh3g18qRw2s9luZ6aT3Eo/WY1dyA2b0awoXgrIqogQfK9t
	Smzn2G6lh79Rd0UTGsLh/R8ZLbnkwxXsyP7Ia8fosGHCqbwrLctdCGPvPs6yapRLCSiM5U0TYCj
	he5C3daxRorHomQca+hckTXotMOVYUejs/j1
X-Received: by 2002:a05:6214:d85:b0:77b:e56:4205 with SMTP id 6a1803df08f44-77b0e564816mr84054216d6.40.1757969470128;
        Mon, 15 Sep 2025 13:51:10 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGoYLmdIb3Nl2+KxO8kfeLmdxlO0+34K3AskfequOVhpHMFSdrtgewyxL9LqdgnVBDw2F8F+w==
X-Received: by 2002:a05:6214:d85:b0:77b:e56:4205 with SMTP id 6a1803df08f44-77b0e564816mr84053866d6.40.1757969469773;
        Mon, 15 Sep 2025 13:51:09 -0700 (PDT)
Received: from thinkpad2024 ([71.217.32.21])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-773292c6357sm51294136d6.67.2025.09.15.13.51.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Sep 2025 13:51:08 -0700 (PDT)
Date: Mon, 15 Sep 2025 16:51:06 -0400
From: "John B. Wyatt IV" <jwyatt@redhat.com>
To: Gabriele Monaco <gmonaco@redhat.com>
Cc: linux-kernel@vger.kernel.org,
	Anna-Maria Behnsen <anna-maria@linutronix.de>,
	Thomas Gleixner <tglx@linutronix.de>,
	Waiman Long <longman@redhat.com>, Tejun Heo <tj@kernel.org>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>,
	cgroups@vger.kernel.org,
	"John B. Wyatt IV" <sageofredondo@gmail.com>
Subject: Re: [PATCH v12 9/9] timers: Exclude isolated cpus from timer
 migration
Message-ID: <aMh8Oq6El_xV9Ls4@thinkpad2024>
References: <20250915145920.140180-11-gmonaco@redhat.com>
 <20250915145920.140180-20-gmonaco@redhat.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250915145920.140180-20-gmonaco@redhat.com>

On Mon, Sep 15, 2025 at 04:59:30PM +0200, Gabriele Monaco wrote:

Your patchset continues to pass when applied against v6.17-rc4-rt3 on a
preview of RHEL 10.2.

rtla osnoise top -c 1 -e sched:sched_switch -s 20 -T 1 -t -d 30m -q

duration:   0 00:30:00 | time is in us
CPU Period       Runtime        Noise  % CPU Aval   Max Noise   Max Single          HW          NMI          IRQ      Softirq       Thread
  1 #1799     1799000001      3351316    99.81371        2336            9         400            0      1799011            0        23795

> This effect was noticed on a 128 cores machine running oslat on the
> isolated cores (1-31,33-63,65-95,97-127). The tool monopolises CPUs,
> and the CPU with lowest count in a timer migration hierarchy (here 1
> and 65) appears as always active and continuously pulls global timers,
> from the housekeeping CPUs. This ends up moving driver work (e.g.
> delayed work) to isolated CPUs and causes latency spikes:
> 

If you do another version; you may want to amend the cover letter to include
this affect can be noticed with a machine with as few as 20cores/40threads
with isocpus set to: 1-9,11-39 with rtla-osnoise-top

Tested-by: John B. Wyatt IV <jwyatt@redhat.com>
Tested-by: John B. Wyatt IV <sageofredondo@gmail.com>

-- 
Sincerely,
John Wyatt
Software Engineer, Core Kernel
Red Hat


