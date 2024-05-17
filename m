Return-Path: <cgroups+bounces-2953-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 711828C8EA4
	for <lists+cgroups@lfdr.de>; Sat, 18 May 2024 01:39:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A24211C2147A
	for <lists+cgroups@lfdr.de>; Fri, 17 May 2024 23:39:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C03861420A0;
	Fri, 17 May 2024 23:39:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="gj4AQC2p"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F31431419A2
	for <cgroups@vger.kernel.org>; Fri, 17 May 2024 23:39:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715989150; cv=none; b=bXG/A2DF39fogSCG/9PklHvoY/VkEErmY+AhLkFQBGVRyjsVQvBVHfeUMYq1U+Px46JdNA0wJCgdoWs5oLskx9hjTkEZzdsaBzmwnDmK+HwAuI8oy93jgH72AoKvwbOv/tZrirESh+RaHUoZwJvQa4iI5mXlNOBfIoHNePQwflQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715989150; c=relaxed/simple;
	bh=mE6TQXEFNZLar0V7aKL6yYlC9JxfNVILfl6MpOsjSXg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VsvG3kP547C08byOMyMY1c/gI95O0KO+0Ern+1wQrwUj8V28Ec38YbU+jaD+wLoiNJ1HEErs5yxR5CYaSpdAiOAPjV1YmZIxAS8AJUgXMRBmDwdKhTQq2FFdH/cGZdQhDyGP3Z/RRKUSFSDSd7cqXkcLjqStTHqCgrroNdLiGYQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=gj4AQC2p; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-a5ce2f0deffso269939666b.3
        for <cgroups@vger.kernel.org>; Fri, 17 May 2024 16:39:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1715989147; x=1716593947; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mE6TQXEFNZLar0V7aKL6yYlC9JxfNVILfl6MpOsjSXg=;
        b=gj4AQC2pvxedXuH4XvV/5Q+J+OKFq7MVtueMzfvLUSc+g9Fg5oaBqTnPvdyT+AvTxA
         jfeD6WqMr/tzX1ZiT11fhOnLDZFR/xzTix/yqqHiK3AS6Kxf9O0UaGdi1krv1jdWBUpD
         NUFqMM+VhwlyDOPlB/6UyeBWN6cbIcd+fnAD772V6kHwne10QICGeDFdu5+82k2UcU5b
         0a5/Lu898ERhMSn5nCUbVqiZVX23GoKMijlg4tootDEHpYRJRI6R6zsPf5GP8GVdHjHo
         abY9DMcG9GjhTspcfTAijvRG1ebRUzOPshUV0Oq+7F8PyKrweK6i9//gMJPEEYmEQZvs
         YxIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715989147; x=1716593947;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mE6TQXEFNZLar0V7aKL6yYlC9JxfNVILfl6MpOsjSXg=;
        b=a5clgpbxkxw2CIN/d9sxcrh5NZrNx6AUmW2mB5ZN6hOEP3BdqhVX/9EYjzwc84K4Mf
         rfcKHgnLfKg8cboGe2JmE2Z1HWzTUSeKkrwqT04YJ3KayjHSpNfKpDgyOs3mMFArlh6o
         PrXgixdCNQTZ0szv8Zt9uWg89HRb4fWpTmAfFNoMQFxCI68H5MOWm/pg/QWNann+EAbs
         SK3dCMAUbEaqin7oGZkMnRCWWSwsUZ36b/loK6MoKPxpmtXBSwBLHz9/Df5Zcakj2Wb2
         DSC9wg8gPGJCr3qBV8S/14bqMlNpT326KI3uBB6RY++eWTOdBqnTheetwRfVdR+IsKcK
         Igmw==
X-Forwarded-Encrypted: i=1; AJvYcCW1AdDzUi0TvF5i6D5SnKIsI31gh0wLPXVCtDD7J52syzxj/NI3gWBFvcR6fvFhBwcU3fstPEzWwx91FqkrEBPaglyeXCo1Ng==
X-Gm-Message-State: AOJu0YzgMs4ukdteL0P1NcADh5kYkqp62c1OMlV/KAYhSc2c3w21HArm
	XRHrW/QCJPCnP/6mEw/8rvEIusVBg3HX5ZA6saaZe5S+UX6GAD/WHX0rVl9Ee4U6sD7hf1tyHES
	ml4G+nWnyNxWWr8w/ghDPRGEPjqWnXihnmWi0
X-Google-Smtp-Source: AGHT+IEWStsd+KuxNepFd6UjRKG3y6uqHDKx4qToLv/yDVLnXEdxCtDa1KZ552hONjDNbgT/EWoqQw24FByBD1VHdPI=
X-Received: by 2002:a17:906:714a:b0:a5a:8ac4:3c4c with SMTP id
 a640c23a62f3a-a5a8ac43e15mr774938666b.68.1715989147046; Fri, 17 May 2024
 16:39:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <202405171353.b56b845-oliver.sang@intel.com>
In-Reply-To: <202405171353.b56b845-oliver.sang@intel.com>
From: Yosry Ahmed <yosryahmed@google.com>
Date: Fri, 17 May 2024 16:38:28 -0700
Message-ID: <CAJD7tkbsvRpYTkrjZ8k2ArQSaU+YkF=6rqtVHdjd1ovErvUE6w@mail.gmail.com>
Subject: Re: [linux-next:master] [memcg] 70a64b7919: will-it-scale.per_process_ops
 -11.9% regression
To: kernel test robot <oliver.sang@intel.com>
Cc: Shakeel Butt <shakeel.butt@linux.dev>, oe-lkp@lists.linux.dev, lkp@intel.com, 
	Linux Memory Management List <linux-mm@kvack.org>, Andrew Morton <akpm@linux-foundation.org>, 
	"T.J. Mercier" <tjmercier@google.com>, Roman Gushchin <roman.gushchin@linux.dev>, 
	Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>, 
	Muchun Song <muchun.song@linux.dev>, cgroups@vger.kernel.org, ying.huang@intel.com, 
	feng.tang@intel.com, fengwei.yin@intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 16, 2024 at 10:56=E2=80=AFPM kernel test robot
<oliver.sang@intel.com> wrote:
>
>
>
> Hello,
>
> kernel test robot noticed a -11.9% regression of will-it-scale.per_proces=
s_ops on:
>
>
> commit: 70a64b7919cbd6c12306051ff2825839a9d65605 ("memcg: dynamically all=
ocate lruvec_stats")
> https://git.kernel.org/cgit/linux/kernel/git/next/linux-next.git master

I think we may want to go back to the approach of reordering the
indices to separate memcg and non-memcg stats. If we really want to
conserve the order in which the stats are exported to userspace, we
can use a translation table on the read path instead of the update
path.

