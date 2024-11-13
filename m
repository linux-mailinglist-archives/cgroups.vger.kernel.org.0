Return-Path: <cgroups+bounces-5533-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 291D39C779B
	for <lists+cgroups@lfdr.de>; Wed, 13 Nov 2024 16:47:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0F556B2D595
	for <lists+cgroups@lfdr.de>; Wed, 13 Nov 2024 14:58:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2F771DFD8C;
	Wed, 13 Nov 2024 14:58:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cPRNdutP"
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1B0D487B0
	for <cgroups@vger.kernel.org>; Wed, 13 Nov 2024 14:58:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731509886; cv=none; b=KcItiSh3kSra8GCiYBL2HHc3r1k1Q8SkvUXTompNn5IBI5jYFmnQuHUpAVizcvYgTirw72qg+V1xVjSHuJzP3jZMogkByNICDA+SL0Dj8XxAtlMTgZgRGHbhrqKypOQKOTF0ys5i98ZCEFTUEg6fx6abW00k3YtzQyqm6wMnl/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731509886; c=relaxed/simple;
	bh=7gR8XVU2CNtYu1Oyh2JjI4aaVwZlNnrmNB4SslkNI3s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ur95YZYOlzgoBNUSyaUOwR/i46WWNYvo1yrVOrbk4zSsG2p6At9f0tCPxNN8Z0GPKjWtI36+nenwBpG1e4k49wcewCnYR8NEuK5QYtMefx5usUPwIU3eTLIIjO4eVIL1Xjk9eBybOOwx/oHHyPlQ+A3xKE48HOSgILrbTaMCrbo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=cPRNdutP; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1731509883;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=R2k38l89u20sHjk8k3TDf4GQjG0PrKhQiw5KJOawrK0=;
	b=cPRNdutPJ1y92yQPPtzO+bF1nacK6dPertHzIs9CLVUx0qQXdvxo1Frfv6v1dLa1z+rUES
	qBw+el00yWvVBeWxiOLy0b+1OZ7ZW5UOtX2jhVz/dE1ImLpYjFzrQ7tWha940Emg9bhXld
	GmJZFN4S/K0t03I+MA8JjMfeOUjQTXI=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-517-rJ5cwGW9OKGvwHCfY4Cx5A-1; Wed, 13 Nov 2024 09:58:01 -0500
X-MC-Unique: rJ5cwGW9OKGvwHCfY4Cx5A-1
X-Mimecast-MFC-AGG-ID: rJ5cwGW9OKGvwHCfY4Cx5A
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-432d7a082b5so2806765e9.0
        for <cgroups@vger.kernel.org>; Wed, 13 Nov 2024 06:58:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731509880; x=1732114680;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=R2k38l89u20sHjk8k3TDf4GQjG0PrKhQiw5KJOawrK0=;
        b=hSBEspTxyAU8Pv4nblgDi3nbKhyQ0pjH2bFBWfdBCX6adYi0tE5JPdpxPJCrdx/YVr
         YhHxv96Qv8ZCxDlX4VWby50i9IqvMNT9Iz3oXxjm41e19k7IlfC1ZIBE9sxxv/z/RUoI
         h8JjDs8IatWldKzOHLxy1GEe8Ww1pU3yL23s3ZWV1FTeSr0ZoUW2Dgm8dyV+fvxFD9Jz
         UpWLKXGDo3DybaHPHBisoj2KVVlq5C8J7nB8tjZ3oa0XXaL7wK/vp8JxGjQchtJUiF/u
         Hr6wy97U4MqEivuXGq7/y/7bDTN0wRc5eRgkwbTi1f3dhqO95fVLVl0BBPeP5bPudlVg
         Ckew==
X-Forwarded-Encrypted: i=1; AJvYcCXC0sgwOeq+c2I8fX7mg8r339MFbPGVmyV3bJyTaJfP6yZmJx3vkiq4/BbzuQIEHZm4nv3CeuGV@vger.kernel.org
X-Gm-Message-State: AOJu0YwU/pf0WMuc3wuy0znyxZrEZZ8HXXmZNujjuZs3Lq73+kldl9X+
	MjDiBW+GJrKj8VLign1D/j+PB8GGRBeAFbJLwPnQQEz9iARosEiPgjGfhnF0hpoipcEOKTNu9OW
	nOmHT//eLpeWkdwqTLhdZQR0dYq2bty9UuaO/WPHRs0caCQtZvVpJMIQ=
X-Received: by 2002:a05:600c:8608:b0:426:5e32:4857 with SMTP id 5b1f17b1804b1-432b77fe58bmr179043085e9.0.1731509880616;
        Wed, 13 Nov 2024 06:58:00 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFbHfPhsWEudGXZ7kN+eXfuDpQRWjyreBI6PrYOBgf6hzoJmN9zYelKhExY/ziaYnQssXzN4Q==
X-Received: by 2002:a05:600c:8608:b0:426:5e32:4857 with SMTP id 5b1f17b1804b1-432b77fe58bmr179042745e9.0.1731509880186;
        Wed, 13 Nov 2024 06:58:00 -0800 (PST)
Received: from jlelli-thinkpadt14gen4.remote.csb (host-80-47-4-194.as13285.net. [80.47.4.194])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-432d54f82b6sm27007005e9.15.2024.11.13.06.57.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Nov 2024 06:57:59 -0800 (PST)
Date: Wed, 13 Nov 2024 14:57:56 +0000
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
Subject: Re: [PATCH 1/2] sched/deadline: Restore dl_server bandwidth on
 non-destructive root domain changes
Message-ID: <ZzS-dDgMwa15P9lL@jlelli-thinkpadt14gen4.remote.csb>
References: <20241113125724.450249-1-juri.lelli@redhat.com>
 <20241113125724.450249-2-juri.lelli@redhat.com>
 <20241113134328.GA402105@pauld.westford.csb>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241113134328.GA402105@pauld.westford.csb>

Hi Phil,

On 13/11/24 08:43, Phil Auld wrote:
> Hi Juri,
> 
> On Wed, Nov 13, 2024 at 12:57:22PM +0000 Juri Lelli wrote:
> > When root domain non-destructive changes (e.g., only modifying one of
> > the existing root domains while the rest is not touched) happen we still
> > need to clear DEADLINE bandwidth accounting so that it's then properly
> > restore taking into account DEADLINE tasks associated to each cpuset
> 
> "restored, taking ..."  ?

Yep.

> > (associated to each root domain). After the introduction of dl_servers,
> > we fail to restore such servers contribution after non-destructive
> > changes (as they are only considered on destructive changes when
> > runqueues are attached to the new domains).
> > 
> > Fix this by making sure we iterate over the dl_server attached to
> > domains that have not been destroyed and add them bandwidth contribution
> > back correctly.
> > 
> > Signed-off-by: Juri Lelli <juri.lelli@redhat.com>
> 
> 
> Looks good to me. 
> 
> 
> Reviewed-by: Phil Auld <pauld@redhat.com>

Thanks!
Juri


