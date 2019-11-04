Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3CE06EDAB5
	for <lists+cgroups@lfdr.de>; Mon,  4 Nov 2019 09:45:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727454AbfKDIpd (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 4 Nov 2019 03:45:33 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:47098 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727444AbfKDIpd (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 4 Nov 2019 03:45:33 -0500
Received: by mail-pf1-f193.google.com with SMTP id 193so10399733pfc.13;
        Mon, 04 Nov 2019 00:45:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=AVaAlCmATHFlK0dvHAUG3sEgiLEXR+TZQcbKSHfoP5E=;
        b=pk7TC0AuOrnyj0hssYvxFezLODw9dYB7tlcSqN78c+2bGPNGjIm4a1xAZOvqz8ydCI
         A4oH+d8e9TMEgiNbl8fjHysdrbKu7WCM+KnvVUoagwf+kR/S31oOQMstUfY38oYzLAr2
         hab8x5YKREAW5cdrJiXjekOxZaDP6K45crQiGUeDvcPtVErX2KxxHTvNry3Cu6dB684n
         3yayEw5+Mhn7JpXl36K6T30x2GckJLTGmlxvD5ocRrIKGU1SIGNc6mGdO9RnHgDg9TgD
         OIOW4Q14mhR8lboh+AM4PGS4j3AvAJ92ETsfIVWLILR6dSYtxQICKviCW6ekwpOJ4vvT
         oteg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=AVaAlCmATHFlK0dvHAUG3sEgiLEXR+TZQcbKSHfoP5E=;
        b=hImJg8HD7fKbx/AVl0TEx9DeQ2lf4D9dxMx/xL3CGCFq39YaTDasDtimSoWlzuXkMJ
         YxT+iK7zboWujOLdnpqx4KqEX7P5A0VgUuHxgzhTrloW2yTvUw4TBBw39NlFWPYE7Kza
         oc6iGTMnE7f4hF8f5HIwcflPmI4s4sHzX636hk8rIjzZeeeMFgCqUVhRtFzvfBlrix1S
         0X+K5QqyzJ0UJXwxsW87d3miPurS9lakg+jRK05341sBgyQj/6P1b9o4gx1Il5KVFpsJ
         wJ8m6y3eIcbpfu9rmod++8QegxfJsKscwYt4VLg8bkd4FFxUlX5WNr3kPtGItUSZYT2B
         kBOQ==
X-Gm-Message-State: APjAAAVxL2Vc17JwB6g9SS9GTVFByXGsCizlNaXiBWme3hmbzMSAsY8d
        dNoKRDjp1mzUMypnG6zTM7g=
X-Google-Smtp-Source: APXvYqxklXsn3Jaaifte/7luVaajnzSm/9Xli33KVu++DNBncPNxL+zmJ+alBTYZtCRrtU446qSgPw==
X-Received: by 2002:a17:90a:178e:: with SMTP id q14mr18178334pja.134.1572857131057;
        Mon, 04 Nov 2019 00:45:31 -0800 (PST)
Received: from gaurie.seo.corp.google.com ([2401:fa00:d:0:1034:ec6b:8056:9e93])
        by smtp.gmail.com with ESMTPSA id z16sm17010221pge.55.2019.11.04.00.45.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Nov 2019 00:45:30 -0800 (PST)
From:   Namhyung Kim <namhyung@kernel.org>
To:     Tejun Heo <tj@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>,
        Li Zefan <lizefan@huawei.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Song Liu <liu.song.a23@gmail.com>, cgroups@vger.kernel.org
Subject: [PATCH v2 0/2] cgroup: Sync cgroup id and inode number
Date:   Mon,  4 Nov 2019 17:45:18 +0900
Message-Id: <20191104084520.398584-1-namhyung@kernel.org>
X-Mailer: git-send-email 2.24.0.rc1.363.gb1bccd3e3d-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Hello,

This patchset changes cgroup inode number and id management to be in
sync with kernfs.  The cgroup inode number is managed by kernfs but
cgroup id is allocated by a separate idr.  The idea is to have a
single id for internal usage, inode number and file handle which can
be accessed from userspace.  Actually this work is from Tejun who also
provided the idea.  I just took over the work and fixed some errors
and finally was able to run perf for testing.

The background of this work is that I want to add cgroup sampling
feature in the perf event subsystem.  As Tejun mentioned that using
cgroup id is not enough and it'd better using file handle instead.
But getting file handle in perf NMI handler is not possible so I want
to get the info from a cgroup node.

The first patch converted kernfs id into a single 64bit number and in
the second patch cgroup uses the kernfs id as cgroup id.

The patches are based on the for-next branch in Tejun's cgroup tree.
Tested with tools/testing/selftests/cgroup/test_stress.sh.

Thanks
Namhyung


Tejun Heo (2):
      kernfs: Convert to u64 id
      cgroup: Use 64bit id from kernfs

 fs/kernfs/dir.c                  | 36 +++++++++++++++++++------------
 fs/kernfs/file.c                 |  4 ++--
 fs/kernfs/inode.c                |  4 ++--
 fs/kernfs/kernfs-internal.h      |  2 --
 fs/kernfs/mount.c                | 92 +++++++++++++++++++++++++++++++++++++++++++++++++-------------------------------
 include/linux/cgroup-defs.h      | 18 ++++------------
 include/linux/cgroup.h           | 17 +++++++--------
 include/linux/exportfs.h         |  5 +++++
 include/linux/kernfs.h           | 47 +++++++++++++++++++++++++----------------
 include/net/netprio_cgroup.h     |  8 +++----
 include/trace/events/writeback.h | 92 ++++++++++++++++++++++++++++++++++++++++----------------------------------------
 kernel/bpf/helpers.c             |  2 +-
 kernel/cgroup/cgroup.c           | 68 +++++++++++++++++++----------------------------------------
 kernel/trace/blktrace.c          | 66 +++++++++++++++++++++++++++------------------------------
 net/core/filter.c                |  4 ++--
 net/core/netprio_cgroup.c        |  4 ++--
 16 files changed, 236 insertions(+), 233 deletions(-)

-- 
2.23.0.700.g56cf767bdb-goog

