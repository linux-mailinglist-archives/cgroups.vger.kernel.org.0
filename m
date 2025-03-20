Return-Path: <cgroups+bounces-7196-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C124BA6A34C
	for <lists+cgroups@lfdr.de>; Thu, 20 Mar 2025 11:07:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 566507AD929
	for <lists+cgroups@lfdr.de>; Thu, 20 Mar 2025 10:06:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75782215049;
	Thu, 20 Mar 2025 10:07:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=codethink.co.uk header.i=@codethink.co.uk header.b="eFGVSAT1"
X-Original-To: cgroups@vger.kernel.org
Received: from imap4.hz.codethink.co.uk (imap4.hz.codethink.co.uk [188.40.203.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F08D2F5E
	for <cgroups@vger.kernel.org>; Thu, 20 Mar 2025 10:07:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=188.40.203.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742465233; cv=none; b=QffQCZTaDZlu4KlglJNqse0cs+t347DGCgfVuBUleo2Q/yzbFamE2F+bsrRiRlxYN3q+uFH5Oth9huy0RwofSXzulH7TgY/rgwg/LwhjMkgPWy5I5/ZdqLe0+rHghQu06nHgIR1GO4hhQBzBdPernVBKFiGT8FuXmewKnpegBPg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742465233; c=relaxed/simple;
	bh=vkwawwZVxF4+h0hJ5sIWXpeiwdGqdYyXlwKTVyFGoxY=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Content-Type; b=EZvy8EtcSWAFUU5hx78p39LowNnhE2RWPF6x/iscu7m5GQGdpDd958F86qLebn9tdsLhSbHEsW3VK3Wek0De51+50ZvSpvR+cV3lB84Kj4W5rvuVPnj8StJkw0JwNH4YX06q+5HMELclyR6uf7OeQqlNd3PzfRae8AnGnLG32mA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=codethink.co.uk; spf=pass smtp.mailfrom=codethink.co.uk; dkim=pass (2048-bit key) header.d=codethink.co.uk header.i=@codethink.co.uk header.b=eFGVSAT1; arc=none smtp.client-ip=188.40.203.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=codethink.co.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codethink.co.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=codethink.co.uk; s=imap4-20230908; h=Sender:Content-Transfer-Encoding:
	Content-Type:Subject:From:To:MIME-Version:Date:Message-ID:Reply-To:Cc:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=vkwawwZVxF4+h0hJ5sIWXpeiwdGqdYyXlwKTVyFGoxY=; b=eFGVSAT1u6r76tGF/jJjoZcO5I
	pL9mq6TpR677bswzZdHcVTpMP4MKU5/ZCUxlLWpbwE5mL+zixpror6RLhlvGxjOudfjjtcSds4WFS
	PyQIkzDXSOyV1fLeAWrFM0OejTZVawX1vHpE/hUGIo2BtsikY6kmVIJM7H7R8sax/LeKTenXSe7lq
	+t+ia0ncKsKy5EE/CX8eBf2X3eAr7doLgX7I+YrtdJflaUlsg6p9tvX/DQr2nlydffX7fAVu/UlNI
	PVattP0C+WnM8MgUVq10rexzFz8bCm+JdNiu8vzA5wPAofZ18WLr6pEjeAKwueYGgPKXkKLjbYChG
	b+PFnhsw==;
Received: from [167.98.27.226] (helo=[10.35.4.191])
	by imap4.hz.codethink.co.uk with esmtpsa  (Exim 4.94.2 #2 (Debian))
	id 1tvCnk-000Hry-FL
	for <cgroups@vger.kernel.org> ; Thu, 20 Mar 2025 10:07:01 +0000
Message-ID: <c5c7fe20-61a6-4228-876e-055ee9ab43b6@codethink.co.uk>
Date: Thu, 20 Mar 2025 10:07:00 +0000
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: cgroups@vger.kernel.org
Content-Language: en-US
From: James Thomas <james.thomas@codethink.co.uk>
Subject: BUG in LTS 5.15.x cpusets with tasks launched by newer systemd
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Sender: james.thomas@codethink.co.uk

Hello all,

I encountered an issue with the CPU affinity of tasks launched by systemd in a
slice, after updating from systemd 254 to by systemd >= 256, on the LTS 5.15.x
branch (tested on v5.15.179).

Despite the slice file stipulating AllowedCPUS=2 (and confirming this was set in
/sys/fs/cgroup/test.slice/cpuset.cpus) tasks launched in the slice would have
the CPU affinity of the system.slice (i.e all by default) rather than 2.

To reproduce:

* Check kernel version and systemd version (I used a debian testing image for
testing)

```
# uname -r
5.15.179
# systemctl --version
systemd 257 (257.4-3)
...
```

* Create a test.slice with AllowedCPUS=2

```
# cat <<EOF > /usr/lib/systemd/system/test.slice
[Unit]
Description=Test slice
Before=slices.target
[Slice]
AllowedCPUs=2
[Install]
WantedBy=slices.target
EOF
# systemctl daemon-reload && systemctl start test.slice
```

* Confirm cpuset

```
# cat /sys/fs/cgroup/test.slice/cpuset.cpus
2
```

* Launch task in slice

```
# systemd-run --slice test.slice yes
Running as unit: run-r9187b97c6958498aad5bba213289ac56.service; invocation ID:
f470f74047ac43b7a60861d03a7ef6f9
# cat
/sys/fs/cgroup/test.slice/run-r9187b97c6958498aad5bba213289ac56.service/cgroup.procs

317
```

# Check affinity

```
# taskset -pc 317
pid 317's current affinity list: 0-7
```

This issue is fixed by applying upstream commits:

18f9a4d47527772515ad6cbdac796422566e6440
cgroup/cpuset: Skip spread flags update on v2
and
42a11bf5c5436e91b040aeb04063be1710bb9f9c
cgroup/cpuset: Make cpuset_fork() handle CLONE_INTO_CGROUP properly

With these applied:

```
# systemd-run --slice test.slice yes
Running as unit: run-r442c444559ff49f48c6c2b8325b3b500.service; invocation ID:
5211167267154e9292cb6b854585cb91
# cat /sys/fs/cgroup/test.slice/run-r442c444559ff49f48c6c2b8325b3b500.service
291
# taskset -pc 291
pid 291's current affinity list: 2
```

Perhaps these are a good candidate for backport onto the 5.15 LTS branch?

Thanks
James

