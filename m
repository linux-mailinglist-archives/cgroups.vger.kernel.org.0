Return-Path: <cgroups+bounces-6181-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DF26FA1345A
	for <lists+cgroups@lfdr.de>; Thu, 16 Jan 2025 08:53:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3CFF0162D00
	for <lists+cgroups@lfdr.de>; Thu, 16 Jan 2025 07:53:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECD7E193402;
	Thu, 16 Jan 2025 07:53:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="NKtJMAhu"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63BDF142E83
	for <cgroups@vger.kernel.org>; Thu, 16 Jan 2025 07:53:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737014014; cv=none; b=FqGbWGTzC+CPQt22/QMIZPLkbNlZ64KGWMIhUwOHaBr6aMcppTa6Ro+j26ShZHlk6ciZq9XJIkVVTqF5vaRJQ0rtoAAkOpmV0DWi8ZlRdCOIBukfPLE3ak7cWsC3z3qfnBy+2P9A1SeHuiOtiuq3MG1Nt1r2DXLfSYmTfbD5n4o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737014014; c=relaxed/simple;
	bh=/9LLynKwP/J0eLOqYcpfhUtHD88p260U61NBx3ufDcg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=G12L55Egs2ZJMkqzUI92rgoYOK+HgDy2vk15VsuDfFYWYbOBk3UuKiEehTfThQXV7HZAMKlbR6G+P5EZ9V9e3MBjCfRuU5RRZWLq8jJHYpOq+CRL1nJdrTrby0L8B2iTFIy7D0FScJFvP+2aIS8UP+tpDLuCWzvhl0nWd49zXOQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=NKtJMAhu; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-385dece873cso317551f8f.0
        for <cgroups@vger.kernel.org>; Wed, 15 Jan 2025 23:53:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1737014010; x=1737618810; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=CZMTPk+iQwyJD5tbO6a3/z2tHTIIc8ZtspJszzFGTgY=;
        b=NKtJMAhuR3NCkOsonBILO0q3VJxGIyVmEcApodYM33m+lJphkGM5F3UDvOrTf7xXa1
         PsG34Exmy0fBcC9Ps3Frd95ys8+Tx03JupaIRvOxOe70tzgkx6JaonwBHrxR9MTMz0zZ
         BduvGL2eM31wMQXgGcwSVDE7baFHW+1ltCko6n3pmSv8HGvLW+TGmRfveFLWgCCbjaOH
         fwRrKZr5yOuHcpkgRAiP/ElS99EZWtm6kt8YrP57VMh+ykrixxqYkt0xwAsBi57mBzSe
         vVPNC3ohSWfQS0P9Z2QUDLYl247Bo8TL430CXjWohWOAA9aqafDbbWx63IsuvHo2UIH/
         IerA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737014010; x=1737618810;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CZMTPk+iQwyJD5tbO6a3/z2tHTIIc8ZtspJszzFGTgY=;
        b=fnEIyv57wIFcciFoPwb2olE8Z+9VJfomQLzRDyxHtjr7+5rbjvcM84A5UiU5CqGTRg
         t/fkEi2zFLSaJx6QYDys9HVLTiaPT7HA6B0b1Xsi8LyidneCJyLmG6Bgjf7F/C35+KO+
         gHDXxTJdnXoeSEmQNOMNNdPanCqQQs/ahyXfy7no7Q0LPmmj+qA/pDNKXrARfi8Ugn9u
         78xqNVGjePwNe/zauO7/8mGVqgRBgADz+p1uRCh8euteoqFpgO7oxuaNjKF2K+/B9aQh
         IGtTnUTxjLAl0NWjrfqOOwxeAX/vpyqPIIOWz9oqb0A3tZote4cbx4u2SaBQoCqtKX99
         LuPg==
X-Forwarded-Encrypted: i=1; AJvYcCVl/XHb9kjSDsiVpAQir7c1zOGdV7x6VGeCX2oKkyXQ4OJVeVT9GQ0nOwY8j5hO++KB2h0G9GTp@vger.kernel.org
X-Gm-Message-State: AOJu0YyNH38USzxhQmAHuCcQNsZy0mLpIH/AEKkM91Q8RFc3yAaiMS1k
	qUDCzOjPE22JK1QA/Du/HIJXtiq0rwC3LlWH/eyDHa2NaXKq+iuC948pRtpM9IY=
X-Gm-Gg: ASbGncutoJ5krPS12Yl4pm7evBOEGhLBOP12l0HN9Nu7tA2yBMAmvU3WUbTaYaGtTaM
	lGM1mhdv7EbkmaHg30jfrJzukrjliOqSWtfyKzpvDPTmRXXHggG+BpxChcCs6v1YwozHVmbJKSI
	1FjbGrvjU010y4Vueta42GNbKOLXcK3bTCdDT2/louRfEvq/8FcpEEuDbuVVq1UW8MpY4i0EmFI
	YE6vPw6CqDNvwskSZvGXmH9mDf7aRKCdgehiPW8r+SD5HPR2H7PiMk2p5VLiP2hVJ/5og==
X-Google-Smtp-Source: AGHT+IH8aE17cnsaSG/lJEJ04ZBg1qqYS0KK3RTQEWRsW7/LFznr+RGN84Vre7HWPegj2Xf82UU+wA==
X-Received: by 2002:a05:6000:1f88:b0:385:fc97:9c63 with SMTP id ffacd0b85a97d-38a872f6915mr23743725f8f.9.1737014010648;
        Wed, 15 Jan 2025 23:53:30 -0800 (PST)
Received: from localhost (109-81-84-225.rct.o2.cz. [109.81.84.225])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-437c7499821sm49818225e9.2.2025.01.15.23.53.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jan 2025 23:53:30 -0800 (PST)
Date: Thu, 16 Jan 2025 08:53:29 +0100
From: Michal Hocko <mhocko@suse.com>
To: Petr Vorel <pvorel@suse.cz>
Cc: Harshvardhan Jha <harshvardhan.j.jha@oracle.com>,
	Li Wang <liwang@redhat.com>, Cyril Hrubis <chrubis@suse.cz>,
	ltp@lists.linux.it, cgroups@vger.kernel.org
Subject: Re: [LTP] Issue faced in memcg_stat_rss while running mainline
 kernels between 6.7 and 6.8
Message-ID: <Z4i6-WZ73FgOjvtq@tiehlicka>
References: <e66fcf77-cf9d-4d14-9e42-1fc4564483bc@oracle.com>
 <PH7PR10MB650583A6483E7A87B43630BDAC302@PH7PR10MB6505.namprd10.prod.outlook.com>
 <20250115125241.GD648257@pevik>
 <20250115225920.GA669149@pevik>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250115225920.GA669149@pevik>

Hi,

On Wed 15-01-25 23:59:20, Petr Vorel wrote:
> Hi Harshvardhan,
> 
> [ Cc cgroups@vger.kernel.org: FYI problem in recent kernel using cgroup v1 ]

It is hard to decypher the output and nail down actual failure. Could
somebody do a TL;DR summary of the failure, since when it happens, is it
really v1 specific?

Thanks!

-- 
Michal Hocko
SUSE Labs

