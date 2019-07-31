Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9C9E47C7B5
	for <lists+cgroups@lfdr.de>; Wed, 31 Jul 2019 17:57:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726993AbfGaP5I (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 31 Jul 2019 11:57:08 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:41102 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725209AbfGaP5H (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 31 Jul 2019 11:57:07 -0400
Received: by mail-pg1-f195.google.com with SMTP id x15so21895893pgg.8
        for <cgroups@vger.kernel.org>; Wed, 31 Jul 2019 08:57:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=zX0JbBzLwtak84PR8Q8R9l/jvRShznUtzc+7fP19S/0=;
        b=ooXvBGRenw+LX61SdmJQ+sDpDqScPbt+b9ZmjaZmAjzrsGmLU5n/VgPmEv7HUDLp+s
         tBGeXbFZEZzdVo26B7300A8D1WyABEAbaF10vuiJ8h15iacPRpb4Y7Yq+YpDMsODH9kW
         2H9nmet6wS7PVc7kAVcAC1YgasgjQejnkYHGClhqUBFCRDwOPsFgN76SnVdbjJ5jBlAE
         6grqn5l0gGAfIbF2XO5fHhfb95yF5LtxHVPBqbZ+zn89NocPrLvEFOyzRcVCU+safjk+
         fHZotfcR1c2n6ApfYXGFmPvEWVm9N/AuC/FTo5UBA/x57ofRo0JLtTS+qUvVcpXRrmgW
         7iEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=zX0JbBzLwtak84PR8Q8R9l/jvRShznUtzc+7fP19S/0=;
        b=ClRYf0zvHjnKQxV4PbvUOF/1XIOaVwGmNl1VvizoBE4xV6geR8sTtemwAseh9XlGj6
         KL+rXOfE4LsFmU2C/79r/SRFGGUYNYIoPoqCgiVGto+4yxyNJlDxx2DBjhCcMPOj3Q0M
         rBJ6MftUApp2WfcWI36LEqag2XZdEnt6wOIIe7qf78cxLixxVLSvIYhVfuhVODeOAh5P
         K8nBf82QicVI/bHUlFApwrU3/zbJR4iznTzYivHJS7Av0WfeuRpeY8e8sWepjurYX1+r
         On3my/ZiAWIqeKcQFx9Eg7bqIRjV7FmsEzk4VL8e246uEE1OIddaPaUD/xtUYlXaRNCn
         1fNw==
X-Gm-Message-State: APjAAAUucVMQW7BZz20vELenT5ghMsW7aWQOUAKfgvIM2zLWMCoB8VYX
        VNePQhvKi8pWBU6Op4bb3zlsIZ8N
X-Google-Smtp-Source: APXvYqypF3oGCGtz+8JPmOrZs5BFkQSNhjp2+Ca4eeakcs/5mFruDKTeYZjiovMBcMjEp5j3vR/5Og==
X-Received: by 2002:a17:90a:9f4a:: with SMTP id q10mr3622673pjv.95.1564588627012;
        Wed, 31 Jul 2019 08:57:07 -0700 (PDT)
Received: from swarm07 ([210.107.197.31])
        by smtp.gmail.com with ESMTPSA id i123sm94910742pfe.147.2019.07.31.08.57.05
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 31 Jul 2019 08:57:06 -0700 (PDT)
Date:   Wed, 31 Jul 2019 15:57:03 +0000
From:   Won-Kyo Choe <wkyo.choe@gmail.com>
To:     cgroups@vger.kernel.org
Cc:     lizefan@huawei.com
Subject: [QUESTION] Write error on cpuset.mems
Message-ID: <20190731155703.GB4407@swarm07>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Hi, all

I've been trying to write a new configuration that a memory node is
applied to the "cpuset.mems" but there is a problem for write.

Here is what I've followed so far:

1. Change dax from device driver to memory [1]
I applied a patch that dax can be turned into a system memory. It is
already merged in v5.1.
I actually have a physical Optane DC memory so currently, there are 3
online nodes on the system.

# numactl --hardware
available: 3 nodes (0-2)

2. Configure cgroup
# mount -t cgroup2 none /sys/fs/cgroup
# mkdir /sys/fs/cgroup/test
# echo +cpuset > /sys/fs/cgroup/cgroup.subtree_control
# cat /sys/fs/cgroup/test/cpuset.mems.effective
0-2
# cat /sys/fs/cgroup/test/cpuset.mems
<empty>

The problem arises when I use a below command:
# echo 0-2 > /sys/fs/cgroup/<cgroup_dir>/cpuset.mems
bash: echo: write error: Invalid argument

Apparently, node 2 has only memory which means it is cpu-less. I
thought I can use any nodes that are written in cpuset.mems.effective
but somehow the last cpu-less node cannot be used. Is this result
expected?

[1]: https://patchwork.kernel.org/cover/10829019/

Regards,
Won-Kyo
