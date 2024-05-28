Return-Path: <cgroups+bounces-3032-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 556E18D2827
	for <lists+cgroups@lfdr.de>; Wed, 29 May 2024 00:41:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EA37A1F26A46
	for <lists+cgroups@lfdr.de>; Tue, 28 May 2024 22:41:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E5B013E052;
	Tue, 28 May 2024 22:41:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c3kiOa9B"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C3D021A0C;
	Tue, 28 May 2024 22:41:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716936094; cv=none; b=dsII2leuOTLYJzrqAG+26UIa7cbdAEyUtH3nPy0TBjHKLsiYl6A9R4LaeaC6v5sYS/H1ydBPAoqBDaGuNxFLGCqlce2lWiL4scQDETLw4IZwn3ZtJXwdooByHOy2myDG1RiFKwKqK/tmuV03oZHZSa12HCYBzfN+IgOVm+9zfXM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716936094; c=relaxed/simple;
	bh=UIsrzkaz1wPu1JTOUJPJS4ShO9BgVhRVdBLndJtFASg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QHvaYqI91XYEU2Dw2cRNcbJ/Fe8jm9Q54b+9NCM9akvGTaBOjidc1glnY7MDEbKJ/BNo8inExrHqJ5s2g9xedLa9aKGfAyncarT6t0bvHeFN66FkP2pkN0D1nwyGGJrZEUf2sXpGKWvUmodO+GYBRzoUpGSZ0ecaVSffu/9lzRg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=c3kiOa9B; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-681907aebebso1057234a12.1;
        Tue, 28 May 2024 15:41:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716936092; x=1717540892; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :from:to:cc:subject:date:message-id:reply-to;
        bh=NW4QKUirvV1brwDDAsMiHdvL81ePNCCRnBG2ksx8gOc=;
        b=c3kiOa9Bhh9jZNcolZ+FsS3Y9j2muF6bhFMBtyDoLBnId7DlmO7/sDr9ZIoO5Sr67h
         D4SrrA1bgpDCsve62FafxWwDPDXyDtuf3sIRY+XCJT7NXFSYGoxwrAjNdwVNEgntNrtb
         gqrAGj9giUWP3t65bWfiCtKsZKW3ioFodWfV4kr6WaWNqTZ9p9FuuP1ADgTlxzClMxtF
         5q6605Tn720wzkDsWpEi9DZoen1LF7mytu1IfQGtRUWh1jCT8LwaP4FXPslhoxtiXqFK
         nJcmnTHEvSQdaO3DXW6M4VrUupO8R2PQSHp1qMSm3AjowO6pv3dDa96Y794EsJKa2MKS
         VbEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716936092; x=1717540892;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NW4QKUirvV1brwDDAsMiHdvL81ePNCCRnBG2ksx8gOc=;
        b=da7xxEi8E9KPi1oIiwfcOFYMapPf/v3WAGXtFPPxqUtT6P/xdhcaQXe/y95ZPQLyWa
         eLFT/YDTDbux3UD7ufZM51LQJM2xgzsQD+1Yga4e+wOvK0pU+IY/fsf488eHp/shagmA
         aAPmzqCB/3LAHK7XYy0bvRrTKfFvl730sePaLPlnW9lHfxrVp+wVjsmMnL/R9pAIh3/l
         KOmDSToYsWVJdaONQ4t40O18qStqEpT/JJXniBiMO5sZWWSWmMlQThWERYBqHQClQ6cP
         PqSe3/+xe9/MOEOSDVXB2fXSlM8sjZq/wyHqYSklBb14V5/sNwxhyBsE8Begh5h8eKtY
         itmg==
X-Forwarded-Encrypted: i=1; AJvYcCX8o417j7FDsvaFZFVh4WuhQbeF4eWKPOPXMqXZv7w3S4SNQyippfT234cFL1QkoIDX8HxzCOO/+fGagpD3d8MiLqQhQPz5dEPC7LqCBDlX+7pEM/0PzfUbwBSXICrq9ugXYvPH5w==
X-Gm-Message-State: AOJu0YzHdxZgIyMpLW63ACaM/WmJtXgOmZbG5wY8EA5cSak5BADC61EK
	RzPq1Kcj/Lm0G2RRCBAYJkWPw47q066Nz5vT6ZT6xta7HjOC8KhS
X-Google-Smtp-Source: AGHT+IFaTiVPO5UV3QfW0H5sO86kXUR40YyISAlU2go1rpphGsPC2EO3tzTrABTmkfkGnjtMYUuCkQ==
X-Received: by 2002:a05:6a21:61e:b0:1af:b2e5:2a5e with SMTP id adf61e73a8af0-1b212f0ea33mr12657886637.49.1716936092200;
        Tue, 28 May 2024 15:41:32 -0700 (PDT)
Received: from localhost (dhcp-141-239-159-203.hawaiiantel.net. [141.239.159.203])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f44c967bcasm85748865ad.176.2024.05.28.15.41.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 May 2024 15:41:31 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date: Tue, 28 May 2024 12:41:30 -1000
From: Tejun Heo <tj@kernel.org>
To: "T.J. Mercier" <tjmercier@google.com>
Cc: Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>,
	Zefan Li <lizefan.x@bytedance.com>,
	Johannes Weiner <hannes@cmpxchg.org>, shakeel.butt@linux.dev,
	cgroups@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] cgroup: Fix /proc/cgroups count for v2
Message-ID: <ZlZdmlN3jpKbtgfN@slm.duckdns.org>
References: <20240528163713.2024887-1-tjmercier@google.com>
 <ZlYzzFYd0KgUnlso@slm.duckdns.org>
 <zrvsmkowongdaqcy3yqb6abh76utimen5ejrnkczd4uq3etesl@jv3xb4uso4yk>
 <ZlZa-j3Q8UqL84Zh@slm.duckdns.org>
 <CABdmKX1fPYjkA2S90NntVFjcoMRvQZY1FjHt780S6KZCsBSRJQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CABdmKX1fPYjkA2S90NntVFjcoMRvQZY1FjHt780S6KZCsBSRJQ@mail.gmail.com>

Hello,

On Tue, May 28, 2024 at 03:38:07PM -0700, T.J. Mercier wrote:
> On Tue, May 28, 2024 at 3:30 PM Tejun Heo <tj@kernel.org> wrote:
> > > At the same time, the info provided currently is incorrect or at least
> > > misleading (when only v2 hierarchy is mounted, it mixes the counts) --
> > > that's what T.J.'s patch attempts to rectify in my understanding.
> >
> > Yeah, I was hoping to phase out that file once folks are all on v2.
> 
> I'll buy a round of drinks when that happens, but aren't we a few
> years out from that? :)

I don't think we're too far off from at least making cgroup1 a CONFIG
option. As for the /proc/cgroups file, it's mostly useless on cgroup2, so I
was hoping that this could be put behind the same CONFIG option. I haven't
really thought through it tho, so it's not a hard set plan or anything.

Thanks.

-- 
tejun

