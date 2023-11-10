Return-Path: <cgroups+bounces-325-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 701DF7E7DEF
	for <lists+cgroups@lfdr.de>; Fri, 10 Nov 2023 18:00:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 84CE41C20B0E
	for <lists+cgroups@lfdr.de>; Fri, 10 Nov 2023 17:00:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0811C1DDFA;
	Fri, 10 Nov 2023 16:59:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="VXkBAdOe"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98FE51DFC4;
	Fri, 10 Nov 2023 16:59:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4A06C433C7;
	Fri, 10 Nov 2023 16:59:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1699635594;
	bh=7D6/INxqAd6tY02KzravmcTFgNVCOfRcWs5MmM/Ltik=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=VXkBAdOehvoe8FAy/Xt3FOOzWJjXQZEXOYdDNzsLqkxmE4fPgVtFOVR/MwCaDnCYb
	 KOUjl/sqV9u7StKud1Z3TY8Mv6Sca4un1iRWVfEwqx3eZ01EOJssJW9zWBYVoId+8e
	 V0zWalk2Jsh9fuh9WfAPksNw7v90rbalkmJEW8+A=
Date: Fri, 10 Nov 2023 08:59:52 -0800
From: Andrew Morton <akpm@linux-foundation.org>
To: Dmitry Rokosov <ddrokosov@salutedevices.com>
Cc: <hannes@cmpxchg.org>, <mhocko@kernel.org>, <roman.gushchin@linux.dev>,
 <shakeelb@google.com>, <muchun.song@linux.dev>, <kernel@sberdevices.ru>,
 <rockosov@gmail.com>, <cgroups@vger.kernel.org>, <linux-mm@kvack.org>,
 <linux-kernel@vger.kernel.org>, <bpf@vger.kernel.org>
Subject: Re: [PATCH v2 0/3] samples: introduce cgroup events listeners
Message-Id: <20231110085952.b55345df8dd18019f0581fc1@linux-foundation.org>
In-Reply-To: <20231110082045.19407-1-ddrokosov@salutedevices.com>
References: <20231110082045.19407-1-ddrokosov@salutedevices.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 10 Nov 2023 11:20:42 +0300 Dmitry Rokosov <ddrokosov@salutedevices.com> wrote:

> To begin with, this patch series relocates the cgroup example code to
> the samples/cgroup directory, which is the appropriate location for such
> code snippets.
> 
> Furthermore, a new cgroup v2 events listener is introduced. This
> listener is a simple yet effective tool for monitoring memory events and
> managing counter changes during runtime.

Is this correctly named?  It's a memcg event listener. 
"cgroup_v2_event_listener" implies that it will display events for
other/all cgroup v2 controllers.

