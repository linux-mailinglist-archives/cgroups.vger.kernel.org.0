Return-Path: <cgroups+bounces-889-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1615F8086AC
	for <lists+cgroups@lfdr.de>; Thu,  7 Dec 2023 12:25:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C5699283D32
	for <lists+cgroups@lfdr.de>; Thu,  7 Dec 2023 11:25:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B89F37D28;
	Thu,  7 Dec 2023 11:25:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=riseup.net header.i=@riseup.net header.b="FDh6T6iE"
X-Original-To: cgroups@vger.kernel.org
Received: from mx1.riseup.net (mx1.riseup.net [198.252.153.129])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59886A3
	for <cgroups@vger.kernel.org>; Thu,  7 Dec 2023 03:25:14 -0800 (PST)
Received: from fews02-sea.riseup.net (fews02-sea-pn.riseup.net [10.0.1.112])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx1.riseup.net (Postfix) with ESMTPS id 4SmBlD25plzDqQ4
	for <cgroups@vger.kernel.org>; Thu,  7 Dec 2023 11:25:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=riseup.net; s=squak;
	t=1701948312; bh=oolDpoKoFysH0OINwySmzIrhbfJoMt2DK9h7Jj0eUcA=;
	h=Date:From:To:Subject:From;
	b=FDh6T6iEBcqM5NBIQdfPExlH0R6Qugju5N300W8Q46u7+U82DS5allUHSz3mvd4Om
	 QX5nh0rL+jbSt6GJt4kzTLTXWA9vlh3+rcPWW8i+ZOY6tyJPh3oYyPNldNiZ7n9E3e
	 63qGadyUfx8P2RkXK4DugRShAamDxQ4UUM9nD4tY=
X-Riseup-User-ID: 5BEBD0ABD1F4639BA419E29A630A03A86DF6AD1E4E77E44A4BABA196D3295F84
Received: from [127.0.0.1] (localhost [127.0.0.1])
	 by fews02-sea.riseup.net (Postfix) with ESMTPSA id 4SmBlC4hPHzFt1g
	for <cgroups@vger.kernel.org>; Thu,  7 Dec 2023 11:25:11 +0000 (UTC)
Date: Thu, 7 Dec 2023 11:25:09 +0000
From: donoban <donoban@riseup.net>
To: cgroups@vger.kernel.org
Subject: EOPNOTSUPP while trying to enable memory on cgroup.subtree_control
Message-ID: <rare3lakkfrp7lkcfosuhivot6vuwuuwkgj74bbzmsjjpgwkt7@udo2e6layb3d>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,

Since some weeks ago 'docker stats' is not showing memory and io:
https://gitlab.alpinelinux.org/alpine/aports/-/issues/15506

After trying to fix it I noticed this behaviour:
  /sys/fs/cgroup/docker/cgroup.controllers has:
    cpuset cpu io memory hugetlb pids
but trying:
  echo +memory > /sys/fs/cgroup/docker/cgroup.subtree_control results:
write(1, "+memory\n", 8)                = -1 EOPNOTSUPP (Not supported)

'cgroup.type' is "domain threaded", I'm not sure if it affects.


Any clue? Is there some bug here or could be some problem with kernel
build/config?

Thanks!

