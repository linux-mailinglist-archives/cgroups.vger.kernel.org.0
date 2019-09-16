Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EF400B3DAF
	for <lists+cgroups@lfdr.de>; Mon, 16 Sep 2019 17:29:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727374AbfIPP3z (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 16 Sep 2019 11:29:55 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:32869 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389125AbfIPP3v (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 16 Sep 2019 11:29:51 -0400
Received: by mail-qt1-f195.google.com with SMTP id r5so341366qtd.0;
        Mon, 16 Sep 2019 08:29:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=Ey0wD9SSrsgQ+GVE+vYc1coFKJxFcUoh6S5jBW7ZYvo=;
        b=r6Tdi/eeQB83Zu0TvOlrODrPbnDctrTtiVLezpx9OYq6F37NtaWbabg56gHTpdI46+
         4PLIar4hiAHgKcM1xNimBS6Yf83anB4wxsER40seAeriMGLA5vBDLGNJe7X65PPCVdrb
         cB7HaOl0pIOlEs6n0a1rqQUqcTCLkz0TupZDeojcFchmrQBGNXQW3ZnfchDR8SQZNCkV
         v6KMEVgJSEsQcXbHCd0qU9rHkuLW7gplk2XZNoejD2u/hd6FyX5Up46CqdLeJncyY7w2
         /RlNtrVqCHgO76Ma36XAB7w9caRNBZ9weXUnuxu9VsijfM2p9OACH2Ri4kYuglIb7mwp
         eXjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mime-version:content-disposition:user-agent;
        bh=Ey0wD9SSrsgQ+GVE+vYc1coFKJxFcUoh6S5jBW7ZYvo=;
        b=hLjQQKvwsGrDypJb4XP5rJ+TEDB9txVr+viyXlYDEBYcoai5HuyazAKmg+ziAicb4y
         4HK5/m7uNsFWGU0s+fTAtgeBoX9nFsIkloASEd4gDHNSacHAGNRMuHnBZdgFI53jriPZ
         Zt8xb+YmPo4MfSWa9tI/70IcasqZ5fUbNvAElOi2lj34Rh+iubVNVWfYrx2+OmFj5+A/
         cV8Up2bYjsrlROcuWDiPZd2yXqlk7v/+UKe2/R3eAV9K1QvW3pzZE5lNIRjqxX9cesHm
         zTeDq50HzD08M/1S8N/j6IlC2Svh5GfsTan9YlAF0NQpNjES0uRuaYxHyYw7U5G+VZQI
         yV9w==
X-Gm-Message-State: APjAAAW0RXBevu5EwLt3GX79eiA2gGTOtE4q28KhS0e1XYPX7tH0aDv3
        dNF/gt4JfEkleH+unLdC9CY=
X-Google-Smtp-Source: APXvYqyXthja/QdH/NMIDXevzStb5/TsM5qOGaLrHnJeAP1ao11hRQe/lnCpRnc+KpP+QrPQjQt9hw==
X-Received: by 2002:a0c:8a6d:: with SMTP id 42mr627069qvu.138.1568647790078;
        Mon, 16 Sep 2019 08:29:50 -0700 (PDT)
Received: from localhost ([2620:10d:c091:480::c30c])
        by smtp.gmail.com with ESMTPSA id b192sm17149426qkg.39.2019.09.16.08.29.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 16 Sep 2019 08:29:49 -0700 (PDT)
Date:   Mon, 16 Sep 2019 08:29:47 -0700
From:   Tejun Heo <tj@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, Li Zefan <lizefan@huawei.com>,
        Johannes Weiner <hannes@cmpxchg.org>, cgroups@vger.kernel.org
Subject: [GIT PULL] cgroup changes for v5.4-rc1
Message-ID: <20190916152947.GE3084169@devbig004.ftw2.facebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Hello, Linus.

Three minor cleanup patches.

Thanks.

The following changes since commit ad5e427e0f6b702e52c11d1f7b2b7be3bac7de82:

  Merge branch 'parisc-5.3-3' of git://git.kernel.org/pub/scm/linux/kernel/git/deller/parisc-linux (2019-07-23 15:34:59 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tj/cgroup.git for-5.4

for you to fetch changes up to 653a23ca7e1e1ae907654e91d028bc6dfc7fce0c:

  Use kvmalloc in cgroups-v1 (2019-08-07 11:37:58 -0700)

----------------------------------------------------------------
Marc Koderer (1):
      Use kvmalloc in cgroups-v1

Markus Elfring (1):
      cgroup: Replace a seq_printf() call by seq_puts() in cgroup_print_ss_mask()

Peng Wang (1):
      cgroup: minor tweak for logic to get cgroup css

 kernel/cgroup/cgroup-v1.c | 27 ++++-----------------------
 kernel/cgroup/cgroup.c    |  4 ++--
 2 files changed, 6 insertions(+), 25 deletions(-)

-- 
tejun
