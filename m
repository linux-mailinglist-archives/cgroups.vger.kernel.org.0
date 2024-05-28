Return-Path: <cgroups+bounces-3026-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 740BF8D2510
	for <lists+cgroups@lfdr.de>; Tue, 28 May 2024 21:45:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A4F501C26F6F
	for <lists+cgroups@lfdr.de>; Tue, 28 May 2024 19:45:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B13261791EB;
	Tue, 28 May 2024 19:43:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P7AlGgMU"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-oo1-f51.google.com (mail-oo1-f51.google.com [209.85.161.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BE48176FBD;
	Tue, 28 May 2024 19:43:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716925392; cv=none; b=puOxeGzA28m4lrzv7fOGNzJlJfIyNRv7zmBeHnO10L51cO5eOesdb1mVRjJdJY74wohgy5n2fXxk78NzmmnW4yUfykoYckxjt6iVWpdH27zWmq8h9nb0AJa2NQ0UyG5vyiRhrdg5Mvjga57ZCJvclJao8EKZB5ugsMRsJneB23o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716925392; c=relaxed/simple;
	bh=ThEsUIZg0oGl9jo2RSi+9PVPHwNBf83WEij7LLS/WDE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=o3KfyTYn5WhEx8KOlMsQXREAQAGq/t0Hmf98LgRfXIlTdcb91j31O9dErkpjpPlLs+xqFsfmpzUifgq7sRHaJdb8Xq2LoL9JQ+QjV+FB8G8Y/dExn9aa+XlxbfhBJwiDhzz17UMsUCfrvjk/r48LxiBqG8Z74dE6eo7+Jag0oS8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=P7AlGgMU; arc=none smtp.client-ip=209.85.161.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f51.google.com with SMTP id 006d021491bc7-5b9b72c4e71so749229eaf.1;
        Tue, 28 May 2024 12:43:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716925390; x=1717530190; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/QuNdJaoaItLZOmxJxJS3BmtxeHxA8HRBPVP5gnc2IE=;
        b=P7AlGgMU/cYpJV8sDRSn0TmxF+gQordROwlINalWrCV3PVe7HpfIlDiRv1s5xc1aUH
         Nz/tpTaqwhu0EzYztoYXXoF2Jbgkojk8TNDXEyMVAhv8S6m/HQCLuTBmwxlDLdfV6C8h
         TkXaLjxqF1SJZbUrOwNEruXN6OIz3toawMfYpsF5Ps09szLgyg3vVRl51JU30EiciDJd
         XwDpygd2d01C7lRK2R5+Jv958rQOOPFa5RqrHWIANrvSVSC3OG6I59pXwEoQKTNSmC+H
         0Kp/uZKdgzvhdORSxFmSSvT7rjO1P7R8sWmbqjduC6zM+itPCYI9n9JgkWHo11TQLjzF
         qPIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716925390; x=1717530190;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/QuNdJaoaItLZOmxJxJS3BmtxeHxA8HRBPVP5gnc2IE=;
        b=tJwLOT6IIluOKCTl61CQXebJ6C6nvmOXyP8GmyO5m3T1lOSrl/WHdESOasMOQ5hkpo
         oerWq1Nj7KNisgyW23fe+zlLNjtLAxpADJNMEMFH3/3cxxUn9rhrdqFPvM6HOXjaKTsW
         stFS+N1zjIe4aQn3wSmrqE3zpU39B+Iqr2BfVUR3j9SkapfxeWaN2an2B8BPcoVI3B6w
         1W+TrR5mzW7Aqfrvye8/iLAX5pyX2Z2BXgnZntg144zosO5epsFsDQrNLtmNZOyODuzo
         +SmPUaF5wr+8dqQBevnaM6p6crV8emXlt+3nCRL40ywhwUoJn0JhCIJNPHzGzJZZHAA7
         P5qw==
X-Forwarded-Encrypted: i=1; AJvYcCU/XaqCpAvPDBmeq3osEcSUiHlSRzMIDDwJ/FQUi8RG57q6d5ELa9ZqiCJbUFneB2S9XvcxFm4F/YmwJFItva98zdhfBhYP6xgUa44xhMNCZZ7g9uwJGT31kGoiZ/GAsB0e8fFpNQ==
X-Gm-Message-State: AOJu0YxxR4IuBoRzruTrwnFHkMUW9c/U+3tAHNJQT+ujK/E/LyXztIyj
	sBbInttUOWAZqfQabJkAGPt7JaSYxMVq+yT62ODgvh0+ZAoJMJB1
X-Google-Smtp-Source: AGHT+IFKo4BSozMj0AbdEJnOud+9Zr12zM68wz1B+h4zUwAhRheMyh20Ao6AFtJZ0FZgtIRZOgXH1w==
X-Received: by 2002:a05:6358:668b:b0:186:249a:c8de with SMTP id e5c5f4694b2df-197e50caf7emr1663193755d.5.1716925389891;
        Tue, 28 May 2024 12:43:09 -0700 (PDT)
Received: from localhost (dhcp-141-239-159-203.hawaiiantel.net. [141.239.159.203])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-682274ba9c8sm7929282a12.78.2024.05.28.12.43.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 May 2024 12:43:09 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date: Tue, 28 May 2024 09:43:08 -1000
From: Tejun Heo <tj@kernel.org>
To: "T.J. Mercier" <tjmercier@google.com>
Cc: mkoutny@suse.com, Zefan Li <lizefan.x@bytedance.com>,
	Johannes Weiner <hannes@cmpxchg.org>, shakeel.butt@linux.dev,
	cgroups@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] cgroup: Fix /proc/cgroups count for v2
Message-ID: <ZlYzzFYd0KgUnlso@slm.duckdns.org>
References: <20240528163713.2024887-1-tjmercier@google.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240528163713.2024887-1-tjmercier@google.com>

Hello,

On Tue, May 28, 2024 at 04:37:12PM +0000, T.J. Mercier wrote:
> The number of cgroups using a controller is an important metric since
> kernel memory is used for each cgroup, and some kernel operations scale
> with the number of cgroups for some controllers (memory, io). So users
> have an interest in minimizing/tracking the number of them.

I agree that this can be a useful metric but am not sure /proc/cgroups is
the right place to put it. Its use of v1 controller names, listing of
controllers that don't exist in v2 and the unnecessary column are rather
ugly and unnecessary. Also, it isn't hierarchical which can make
understanding where the css's are staying allocated difficult.

In v2, cgroup.controllers and cgroup.subtree_control govern which
controllers are available and enabled in the subtree. I think it would make
sense to introduce something in a similar fashion. Can't think of a good
name off the top of my head but add a cgroup. file which lists the
controllers in the subtree along with the number of css's.

Thanks.

-- 
tejun

