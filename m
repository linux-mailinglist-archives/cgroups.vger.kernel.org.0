Return-Path: <cgroups+bounces-550-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CCCD57F84D8
	for <lists+cgroups@lfdr.de>; Fri, 24 Nov 2023 20:42:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 851A5283943
	for <lists+cgroups@lfdr.de>; Fri, 24 Nov 2023 19:42:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F82339FC2;
	Fri, 24 Nov 2023 19:42:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="m7Bo3msM"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 229D83A8CA;
	Fri, 24 Nov 2023 19:42:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4478DC433C8;
	Fri, 24 Nov 2023 19:42:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1700854951;
	bh=ezc0uKQjJ7QBtbFGAWq/OpSXh4KP6g8aXlUNpY+KlCY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=m7Bo3msMtQf6IcfuqT9j39hHZoT6qqHydL29EWYC3/fa/tzP+zADtWz0v5MaF3sOf
	 hfq6lqpRstJmqJMwxMsExSvJevFHdfTSsEWnyQotY5cw8EkObHKyxaKjmq3ifSzutn
	 vMdF1RopqRBYl2E2sVbxLC5Pp6QZCG9WG098zNJM=
Date: Fri, 24 Nov 2023 11:42:30 -0800
From: Andrew Morton <akpm@linux-foundation.org>
To: Dmitry Rokosov <ddrokosov@salutedevices.com>
Cc: <hannes@cmpxchg.org>, <mhocko@kernel.org>, <roman.gushchin@linux.dev>,
 <shakeelb@google.com>, <muchun.song@linux.dev>, <kernel@sberdevices.ru>,
 <rockosov@gmail.com>, <cgroups@vger.kernel.org>, <linux-mm@kvack.org>,
 <linux-kernel@vger.kernel.org>, <bpf@vger.kernel.org>
Subject: Re: [PATCH v3 0/3] samples: introduce cgroup events listeners
Message-Id: <20231124114230.22ed97e85058dc339947f13f@linux-foundation.org>
In-Reply-To: <20231123071945.25811-1-ddrokosov@salutedevices.com>
References: <20231123071945.25811-1-ddrokosov@salutedevices.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 23 Nov 2023 10:19:42 +0300 Dmitry Rokosov <ddrokosov@salutedevices.com> wrote:

> To begin with, this patch series relocates the cgroup example code to
> the samples/cgroup directory, which is the appropriate location for such
> code snippets.

butbut.  Didn't we decide to do s/cgroup/memcg/ throughout?

