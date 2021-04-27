Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6005C36C10D
	for <lists+cgroups@lfdr.de>; Tue, 27 Apr 2021 10:36:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235033AbhD0Ihk (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 27 Apr 2021 04:37:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234775AbhD0Ihk (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 27 Apr 2021 04:37:40 -0400
Received: from mail-qt1-x830.google.com (mail-qt1-x830.google.com [IPv6:2607:f8b0:4864:20::830])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5403AC061756
        for <cgroups@vger.kernel.org>; Tue, 27 Apr 2021 01:36:57 -0700 (PDT)
Received: by mail-qt1-x830.google.com with SMTP id z25so20883227qtn.8
        for <cgroups@vger.kernel.org>; Tue, 27 Apr 2021 01:36:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ugedal.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zh33Yh7lW0dlBQiRgpyt2psV9Y8igA+5UjDIZx32BfY=;
        b=R80hr1wa0Mn4k9VnGUbjc2R4cixMJ5ZgNIsARabk5tPMu6Xepea/w5ho7Xc+BrYwxe
         RzVMetIIjm8bZYHV94xbetqPI3rgYcmAT7Nrf8Dq39rGvxBcqXoeXnQ7GesBx3HvsUES
         y8tiElerXVsLUim5FOz5JOxbTJoBMrtc63Y/8T+OOTjI7PYvJ0/xb4rO/cOynbxkZZUf
         EyqUNqvy6ym8veTJ9KzmuW0L/PJlrPuQ9zJAejiUYWsuDsIUEffKgPUIlE7cYyTAucyZ
         MW76yf/Qz4jtb3+hk6kV9THp4URfVjGSiTN+UZmk55DKeUifX6PsQ7ZTvUmp9qKKJ+Gl
         J5yQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zh33Yh7lW0dlBQiRgpyt2psV9Y8igA+5UjDIZx32BfY=;
        b=ZgfIDCtI13Vt/XDivXL7RCKN0NqNGlULfgpUO1J8U1Sx8QKNJmgaQ6RVtpJwJdquoN
         66n1HjYokDZps7utO3VQ97wx2g2iBIWlLy4ISwxl+z/IdXLCElVcBX+vNTmDPKAWzKDL
         140dnuazwHG28dHvT4twZTrMIYSesm23gLU5kib7hDFuyEHUCRHU+e9LGc69ODS+qNDR
         4fWGYATcad+XtSUKqJy/uN1UScS6vBxbnFAixx+KrPS02K4B3m5L2QvduvCMfigP4PBx
         Xu3NefwglAgqW4hbdE9tgD6CzFZyaKz0wbWK1JVzAGcBmOqwvPVDrgvugW48vRfPXemE
         9R5g==
X-Gm-Message-State: AOAM5303D51C/+LOZK7T73GiKWIG2k3Yeafza6wf2Q4+8VpPSjuRoFGn
        nQAR7HW3xHbe2IQOukQ8zJrUpOpawbcm+vbYMUE0LA==
X-Google-Smtp-Source: ABdhPJxwEQoqK1+7Zd5/B+YbEcN+q2Fk1MdLCZD6xZP6/yvGxn2Ab8Yj5PTWp5aDdVqeHgbeEB+SAwGmx28MYqZ/ug8=
X-Received: by 2002:a05:622a:14c9:: with SMTP id u9mr20628968qtx.313.1619512616470;
 Tue, 27 Apr 2021 01:36:56 -0700 (PDT)
MIME-Version: 1.0
References: <20210425080902.11854-1-odin@uged.al> <CAKfTPtBHm+CjBTA614P9F2Vx3Bj7vv9Pt0CGFsiwqcrTFmKzjg@mail.gmail.com>
In-Reply-To: <CAKfTPtBHm+CjBTA614P9F2Vx3Bj7vv9Pt0CGFsiwqcrTFmKzjg@mail.gmail.com>
From:   Odin Ugedal <odin@ugedal.com>
Date:   Tue, 27 Apr 2021 10:36:23 +0200
Message-ID: <CAFpoUr2t0OXLJZi9wJzYg2uOhSLfwRa7sxCxxWzriJgXDsgEdA@mail.gmail.com>
Subject: Re: [PATCH 0/1] sched/fair: Fix unfairness caused by missing load decay
To:     Vincent Guittot <vincent.guittot@linaro.org>
Cc:     Odin Ugedal <odin@uged.al>, Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        "open list:CONTROL GROUP (CGROUP)" <cgroups@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Also, instead of bpftrace, one can look at the /proc/sched_debug file,
and infer from there.

Something like:

$ cat /proc/sched_debug | grep ":/slice" -A 28 | egrep "(:/slice)|load_avg"

gives me the output (when one stress proc gets 99%, and the other one 1%):

cfs_rq[0]:/slice/cg-2/sub
  .load_avg                      : 1023
  .removed.load_avg              : 0
  .tg_load_avg_contrib           : 1035
  .tg_load_avg                   : 1870
  .se->avg.load_avg              : 56391
cfs_rq[0]:/slice/cg-1/sub
  .load_avg                      : 1023
  .removed.load_avg              : 0
  .tg_load_avg_contrib           : 1024
  .tg_load_avg                   : 1847
  .se->avg.load_avg              : 4
cfs_rq[0]:/slice/cg-1
  .load_avg                      : 4
  .removed.load_avg              : 0
  .tg_load_avg_contrib           : 4
  .tg_load_avg                   : 794
  .se->avg.load_avg              : 5
cfs_rq[0]:/slice/cg-2
  .load_avg                      : 56401
  .removed.load_avg              : 0
  .tg_load_avg_contrib           : 56700
  .tg_load_avg                   : 57496
  .se->avg.load_avg              : 1008
cfs_rq[0]:/slice
  .load_avg                      : 1015
  .removed.load_avg              : 0
  .tg_load_avg_contrib           : 1009
  .tg_load_avg                   : 2314
  .se->avg.load_avg              : 447


As can be seen here, no other cfs_rq for the relevant cgroups are
"active" and listed, but they still contribute to eg. the "tg_load_avg". In this
example, "cfs_rq[0]:/slice/cg-1" has a load_avg of 4, and contributes with 4 to
tg_load_avg.  However, the total total tg_load_avg is 794. That means
that the other 790 have to come from somewhere, and in this example,
they come from the cfs_rq on another cpu.

Hopefully that clarified a bit.

For reference, here is the output when the issue is not occuring:
cfs_rq[1]:/slice/cg-2/sub
  .load_avg                      : 1024
  .removed.load_avg              : 0
  .tg_load_avg_contrib           : 1039
  .tg_load_avg                   : 1039
  .se->avg.load_avg              : 1
cfs_rq[1]:/slice/cg-1/sub
  .load_avg                      : 1023
  .removed.load_avg              : 0
  .tg_load_avg_contrib           : 1034
  .tg_load_avg                   : 1034
  .se->avg.load_avg              : 49994
cfs_rq[1]:/slice/cg-1
  .load_avg                      : 49998
  .removed.load_avg              : 0
  .tg_load_avg_contrib           : 49534
  .tg_load_avg                   : 49534
  .se->avg.load_avg              : 1023
cfs_rq[1]:/slice/cg-2
  .load_avg                      : 1
  .removed.load_avg              : 0
  .tg_load_avg_contrib           : 1
  .tg_load_avg                   : 1
  .se->avg.load_avg              : 1023
cfs_rq[1]:/slice
  .load_avg                      : 2048
  .removed.load_avg              : 0
  .tg_load_avg_contrib           : 2021
  .tg_load_avg                   : 2021
  .se->avg.load_avg              : 1023


Odin
