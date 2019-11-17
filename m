Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B2F4FFFA1F
	for <lists+cgroups@lfdr.de>; Sun, 17 Nov 2019 15:09:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726184AbfKQOJQ (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Sun, 17 Nov 2019 09:09:16 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:59090 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726037AbfKQOJP (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Sun, 17 Nov 2019 09:09:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1573999753;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=z3jThtnFHn+u2Zbntihdur7DaqZTHatfWOLXJf5lMaI=;
        b=ZK6WU3pIB3z5PCk6NE7sbDAUa9ppvQuZK1HhHh3QS8fj0vR3J9rBfpvexTVJyrhKvYgvH/
        UytZS5zosBMt87s2ip7mi6hD9KdWBMlQsVGSdyOg8Fk3p0dw0RHJA4Mswa4qTZtEITGgXi
        STP/t/LxDDGLRDUD0WQsI6TIy1uppP0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-423-6JacbFZ6Mbyq1yJB19xQJA-1; Sun, 17 Nov 2019 09:09:12 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E66D31005500;
        Sun, 17 Nov 2019 14:09:10 +0000 (UTC)
Received: from localhost (dhcp-12-102.nay.redhat.com [10.66.12.102])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 5EAF16090B;
        Sun, 17 Nov 2019 14:09:10 +0000 (UTC)
Date:   Sun, 17 Nov 2019 22:16:59 +0800
From:   Zorro Lang <zlang@redhat.com>
To:     linux-block@vger.kernel.org
Cc:     cgroups@vger.kernel.org, bfoster@vger.kernel.org,
        fstests@vger.kernel.org
Subject: Question about block cgroup for disk partition
Message-ID: <20191117141658.GP3802@dhcp-12-102.nay.redhat.com>
MIME-Version: 1.0
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-MC-Unique: 6JacbFZ6Mbyq1yJB19xQJA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Hi,

Recently we found a weird failure by running xfstests generic/563 on xfs or
ext4, when the test device is a general disk partition. If you don't want t=
o
try xfstests, you can see below script[1].

If we test on a disk partition (e.g. /dev/sdb1 or /dev/nvme0n1p1), the cgro=
up's
io.stat always can't output the correct minor device number of the disk
partition. LVM or loop devices don't have this issue.

Is there any 'blk-cgroup' expert would like to help to answer this question=
?
Is this expected or it's a bug will be fixed later? It can be reproduced on
latest upstream kernel.

Thanks,
Zorro


[1]
# cat blkcgroup-test.sh=20
#/bin/bash

umount /dev/nvme0n1p1 2>/dev/null
mkfs.xfs -f /dev/nvme0n1p1 >/dev/null 2>&1
mount /dev/nvme0n1p1 /mnt/scratch
major=3D$((0x`stat -L -c "%t" /dev/nvme0n1p1`))
minor=3D$((0x`stat -L -c "%T" /dev/nvme0n1p1`))
echo "$major:$minor"
echo "+io" > /sys/fs/cgroup/cgroup.subtree_control
echo $$ > /sys/fs/cgroup/cgroup.procs
rmdir /sys/fs/cgroup/mytest-cg
xfs_io -fc "pwrite 0 8m" /mnt/scratch/file >/dev/null 2>&1
umount /dev/nvme0n1p1 && mount /dev/nvme0n1p1 /mnt/scratch
stat /mnt/scratch/file >/dev/null
mkdir /sys/fs/cgroup/mytest-cg
echo $$ > /sys/fs/cgroup/mytest-cg/cgroup.procs
xfs_io -c "pread 0 8m" -c "pwrite 0 8m" -c fsync /mnt/scratch/file >/dev/nu=
ll 2>&1
mkdir -p /sys/fs/cgroup
echo $$ > /sys/fs/cgroup/cgroup.procs
xfs_io -c fsync /mnt/scratch/file
cat /sys/fs/cgroup/mytest-cg/io.stat

[2]
259:1
259:0 rbytes=3D8388608 wbytes=3D8389632 rios=3D67 wios=3D12 dbytes=3D0 dios=
=3D0

