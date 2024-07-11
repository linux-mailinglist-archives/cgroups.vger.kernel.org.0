Return-Path: <cgroups+bounces-3622-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B3FD92E9DC
	for <lists+cgroups@lfdr.de>; Thu, 11 Jul 2024 15:49:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BAD182840ED
	for <lists+cgroups@lfdr.de>; Thu, 11 Jul 2024 13:49:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9AAF16131A;
	Thu, 11 Jul 2024 13:49:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b="A+MukzNr"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D2E91607AF
	for <cgroups@vger.kernel.org>; Thu, 11 Jul 2024 13:49:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720705775; cv=none; b=owOsnPs8Mv2y7/JxdIs65KUrSAU26r+4iGsbWqJlRZDtw1q0i9jzXK9dMUsj3PehJdT/FMv7mfUJC4ObWc7se/gnQd/8D0AgkaxPfdZdF3p/m9R6tGZ7kl2cw4vOcV/ngnlm6MGarKex4mC3Erbclo9AMW6FTTqQZ/HMpTcTLDc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720705775; c=relaxed/simple;
	bh=+3RA/WCEZOLvNp1kfnEI1aI9/Vj5N0p7XqouO3rUMnA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=D6y7t4hdZa3LBLGAa2hrVlaQRt0XsIo7MJ5vuhmc403PI1KUBm7FcaEOdCb4tj52F8ZNJWRu4LcvFNJdsDxQxct1I1s7EMHUQOZdG0ryWGzrjuqfAgxLf8RD8aB3awsKh6oJOVoS99H2RhkvPwyN+1ZfjpwdC6iY1z1f0cmfrHk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org; spf=pass smtp.mailfrom=cmpxchg.org; dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b=A+MukzNr; arc=none smtp.client-ip=209.85.222.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmpxchg.org
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-7a05b4fa525so69671185a.1
        for <cgroups@vger.kernel.org>; Thu, 11 Jul 2024 06:49:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20230601.gappssmtp.com; s=20230601; t=1720705772; x=1721310572; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=4c/thh0gX3Wuy0Qhdv01QxrBoTYgtRK1bsGV9IACHGk=;
        b=A+MukzNrL8Sk1y0udzdaX/RHYy4Ys5oqxxPuqsjU3dNC7hF90THiWfJp7fsXsDjNVz
         /uLmAmprzkMpOuN3T59Fu7nvJXneA8Jc0ls1Yf1AQBscX7xCShPrQ71/sWtl2GvuDDDe
         JeEVx6VFSNGCrpK9ZN26h7pSqAMpvyDvytEPFVG8YkrouQV06VVDAIrOeEws/no26G4Y
         QAhonNFkPDH9St3lEfd9oKmE7aAWRmurVhKMsmEg/+0/r8dd+LkdTNgiHBmPjQTO8cAl
         4O27JgpgRz3+i7rMpsKblD5XESq5TS3ADqDyp5Ld1sw1+PLg5DlPlI6HcshEPx5T8gnZ
         kiFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720705772; x=1721310572;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4c/thh0gX3Wuy0Qhdv01QxrBoTYgtRK1bsGV9IACHGk=;
        b=xDwH00U7wyRhgdw8YQDZ6NFZvdVX+wTdfyzc1GVEZ+pvhdjY/zA6rI0mskwzzC09jG
         i68N33WNEKTSRz0h13FvyWGa4QzW6MMKoiDJjQ8cAGtYCa4Hn7YCD1B+sh2PrrqMppxt
         5Wo8IibK8YweShHeIj3/0PedZxHZvrTG99tefuXOfmqNHupehNanrrBm8UKFQTVqhNfM
         bAldCZB2RxZarDPJR+j1MWbZ+PuCvtX0psTvbCYy/0QNjjNfh1xDXSRZrzZpBDio6Q3g
         5IIK6SWU/Zm1rUXV9f5FvmUIaay3RoM9r7Taz9XaSfTzkBthfCKcqZiUDg5Q8K1XOnqI
         t1qQ==
X-Forwarded-Encrypted: i=1; AJvYcCUfp/0NDRs0Wo8WA4eScPr6SL4Thhjy3850UxuOM3FC7LzV/9GCbnicsYjVDkhk+J6eiBfC/dXGuSW90w3mmG7dHcpywEonOw==
X-Gm-Message-State: AOJu0Yy7hcSFED0xc1FnudXmjJJr1BFjguXeuAERmQldVF768CkGGeB0
	6GnrHIC8hUkYZn74j15efVL8qn5WBRcpPEt/r6EMxetZKhTwaJKol+VvZDhz8Xs=
X-Google-Smtp-Source: AGHT+IHwEOYVfSWxKEQP0w8KFn4k/nB2bnIk+/F2DNotqRksDFSC7MbAwOqVXy2Rh4H9nIWY4EYR3Q==
X-Received: by 2002:a05:620a:4723:b0:79f:e0d:e052 with SMTP id af79cd13be357-7a1469bce11mr482286985a.9.1720705772260;
        Thu, 11 Jul 2024 06:49:32 -0700 (PDT)
Received: from localhost ([2603:7000:c01:2716:da5e:d3ff:fee7:26e7])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-79f190b4468sm291254485a.128.2024.07.11.06.49.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jul 2024 06:49:31 -0700 (PDT)
Date: Thu, 11 Jul 2024 09:49:27 -0400
From: Johannes Weiner <hannes@cmpxchg.org>
To: Waiman Long <longman@redhat.com>
Cc: Tejun Heo <tj@kernel.org>, Zefan Li <lizefan.x@bytedance.com>,
	Jonathan Corbet <corbet@lwn.net>, cgroups@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	Kamalesh Babulal <kamalesh.babulal@oracle.com>,
	Roman Gushchin <roman.gushchin@linux.dev>
Subject: Re: [PATCH v3 1/2] cgroup: Show # of subsystem CSSes in cgroup.stat
Message-ID: <20240711134927.GB456706@cmpxchg.org>
References: <20240710182353.2312025-1-longman@redhat.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240710182353.2312025-1-longman@redhat.com>

On Wed, Jul 10, 2024 at 02:23:52PM -0400, Waiman Long wrote:
> @@ -3669,12 +3669,34 @@ static int cgroup_events_show(struct seq_file *seq, void *v)
>  static int cgroup_stat_show(struct seq_file *seq, void *v)
>  {
>  	struct cgroup *cgroup = seq_css(seq)->cgroup;
> +	struct cgroup_subsys_state *css;
> +	int ssid;
>  
> +	/* cgroup_mutex required for for_each_css() */
> +	cgroup_lock();
>  	seq_printf(seq, "nr_descendants %d\n",
>  		   cgroup->nr_descendants);
>  	seq_printf(seq, "nr_dying_descendants %d\n",
>  		   cgroup->nr_dying_descendants);
>  
> +	/*
> +	 * Show the number of live and dying csses associated with each of
> +	 * non-inhibited cgroup subsystems bound to cgroup v2 if non-zero.
> +	 */
> +	for_each_css(css, ssid, cgroup) {
> +		if ((BIT(ssid) & cgrp_dfl_inhibit_ss_mask) ||
> +		    (cgroup_subsys[ssid]->root !=  &cgrp_dfl_root))
> +			continue;
> +
> +		seq_printf(seq, "nr_%s %d\n", cgroup_subsys[ssid]->name,
> +			   css->nr_descendants + 1);
> +		/* Current css is online */
> +		if (css->nr_dying_descendants)
> +			seq_printf(seq, "nr_dying_%s %d\n",
> +				   cgroup_subsys[ssid]->name,
> +				   css->nr_dying_descendants);
> +	}

I think it'd be better to print the dying count unconditionally. It
makes the output more predictable for parsers, and also it's clearer
to users which data points are being tracked and reported.

With that, and TJ's "subsys" suggestion for the name, it looks good to
me. Thanks!

