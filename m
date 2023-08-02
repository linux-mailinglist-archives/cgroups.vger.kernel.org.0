Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 86A6F76DA5C
	for <lists+cgroups@lfdr.de>; Thu,  3 Aug 2023 00:03:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233523AbjHBWDg (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 2 Aug 2023 18:03:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233450AbjHBWDf (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 2 Aug 2023 18:03:35 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E46941FEF
        for <cgroups@vger.kernel.org>; Wed,  2 Aug 2023 15:03:33 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id a640c23a62f3a-98377c5d53eso37975466b.0
        for <cgroups@vger.kernel.org>; Wed, 02 Aug 2023 15:03:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1691013812; x=1691618612;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=HIo3KTyr76k6K1BA/QNGBKeMcM+9rrKO+UG5HeIlUAM=;
        b=P45Kscjf3OEWZ8OppUx9kF8H15Yd5cbLbFtqdc5LjrYU6q+R+whrc7inBwtatoqMy7
         IDRGZ7zi0UzY+SBvuz37cl3R4M3iyHS3gJ/O6fLmZVcyvMA6+jqetWNxu+04ksSj4y7j
         SKnSdjOenyIwiqgOeyzOXSofnTeGALl/BHm+4eziWASUs9HOB7afyEYGOSEJEhd5pW+m
         Jqoxe+vEXQKCNXGSXvRfnPtt+i3YqOjhnuoIBGSaFPcyVZDnNkSxUTK3ivcrUMHArmJD
         ZrAhOCGnbLprKU9L4JG4XYeLT7SPR0eqV7FvNosqGDBzvn+UvwH3wX06BMbm/KS6VPK9
         bSyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691013812; x=1691618612;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HIo3KTyr76k6K1BA/QNGBKeMcM+9rrKO+UG5HeIlUAM=;
        b=aADjzj/UGDjEjZ7ml8SctlQNXm7rAy75KaK3cuzPuwS48T4G5/6708V8872CJQhSIU
         B9w2hioCMCc++5Fo/KBai7Yf01LFI6LXcm+arjeDaaFQHMprfiTfHtekPPcdmTMJIqxT
         j3skbfmmYFy01UpePJbwndbz5+4bNQ6F2iFjuxBLaJRJ1SxcVwhxxM2WWa2Mohvihb4c
         LQ9obiHjbHUrB/TpU70k42XDoGe8ZnatJfTc0tIBtm6FwD56kR6sgbEx3QFMgHWdIx2+
         FoYlF4DhdMWy+oinYdOIACR/M/CyIXVhiwT5uBOQ/emrQvYPb6i5a+wMVgRA1LvDGpDJ
         mpDQ==
X-Gm-Message-State: ABy/qLaD4koteDqXDw3gjogxOyC64LO/et0DKVI/qzqioKwb3D194Cej
        ikWU3TPBiDsn8QI/FBwhW+ggsK7dqvdCgmV3SgSZ1w==
X-Google-Smtp-Source: APBJJlFTftZm3m5lcjbMgQ2ymx11qxhas8V+QpXpKyaiCiGLnZSf7izHWUaM2LELOMUBMQsG1Y8hGPtoioeBTXsP7DE=
X-Received: by 2002:a17:906:53d3:b0:99b:d9f3:9a98 with SMTP id
 p19-20020a17090653d300b0099bd9f39a98mr6126651ejo.74.1691013812145; Wed, 02
 Aug 2023 15:03:32 -0700 (PDT)
MIME-Version: 1.0
References: <20230726153223.821757-1-yosryahmed@google.com>
 <20230726153223.821757-2-yosryahmed@google.com> <ZMkXDuwD8RFRKnNQ@dhcp22.suse.cz>
 <CAJD7tkbb8AWR-duWb+at-S9MMz48b0JqnM+b5ok83TzvXvPb+A@mail.gmail.com>
 <CAJD7tkbZi16w4mYngVK8qA84FMijmHvwzMjHfrJiCsV=WjixOA@mail.gmail.com>
 <ZMoIYLwITUZzXp4C@dhcp22.suse.cz> <CAJD7tkY4hTTCfqSGa_XexbH=WSTJ4WXWeMXSU+6KW8qfr7agfQ@mail.gmail.com>
In-Reply-To: <CAJD7tkY4hTTCfqSGa_XexbH=WSTJ4WXWeMXSU+6KW8qfr7agfQ@mail.gmail.com>
From:   Yosry Ahmed <yosryahmed@google.com>
Date:   Wed, 2 Aug 2023 15:02:55 -0700
Message-ID: <CAJD7tkb17x=qwoO37uxyYXLEUVp15BQKR+Xfh7Sg9Hx-wTQ_=w@mail.gmail.com>
Subject: Re: [PATCH v3] mm: memcg: use rstat for non-hierarchical stats
To:     Michal Hocko <mhocko@suse.com>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Shakeel Butt <shakeelb@google.com>,
        Muchun Song <muchun.song@linux.dev>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
        linux-mm@kvack.org
Content-Type: multipart/mixed; boundary="000000000000967e290601f7d566"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

--000000000000967e290601f7d566
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 2, 2023 at 1:11=E2=80=AFAM Yosry Ahmed <yosryahmed@google.com> =
wrote:
>
> On Wed, Aug 2, 2023 at 12:40=E2=80=AFAM Michal Hocko <mhocko@suse.com> wr=
ote:
> >
> > On Tue 01-08-23 10:29:39, Yosry Ahmed wrote:
> > > On Tue, Aug 1, 2023 at 9:39=E2=80=AFAM Yosry Ahmed <yosryahmed@google=
.com> wrote:
> > [...]
> > > > > Have you measured any potential regression for cgroup v2 which co=
llects
> > > > > all this data without ever using it (AFAICS)?
> > > >
> > > > I did not. I did not expect noticeable regressions given that all t=
he
> > > > extra work is done during flushing, which should mostly be done by =
the
> > > > asynchronous worker, but can also happen in the stats reading conte=
xt.
> > > > Let me run the same script on cgroup v2 just in case and report bac=
k.
> > >
> > > A few runs on mm-unstable with this patch:
> > >
> > > # time cat /sys/fs/cgroup/cg*/memory.stat > /dev/null
> >
> > Is this really representative test to make? I would have expected the
> > overhead would be mostly in mem_cgroup_css_rstat_flush (if it is visibl=
e
> > at all of course). This would be more likely visible in all cpus busy
> > situation (you can try heavy parallel kernel build from tmpfs for
> > example).
>
>
> I see. You are more worried about asynchronous flushing eating cpu
> time rather than the synchronous flushing being slower. In fact, my
> test is actually not representative at all because probably most of
> the cgroups either do not have updates or the asynchronous flusher got
> to them first.
>
> Let me try a workload that is more parallel & cpu intensive and report
> back. I am thinking of parallel reclaim/refault loops since both
> reclaim and refault paths invoke stat updates and stat flushing.
>

I am back with more data.

So I wrote a small reclaim/refault stress test that creates (NR_CPUS *
2) cgroups, assigns them limits, runs a worker process in each cgroup
that allocates tmpfs memory equal to quadruple the limit (to invoke
reclaim) continuously, and then reads back the entire file (to invoke
refaults). All workers are run in parallel, and zram is used as a
swapping backend. Both reclaim and refault have conditional stats
flushing. I ran this on a machine with 112 cpus, once on mm-unstable,
and once on mm-unstable with this patch reverted. The script is
attached.

(1) A few runs without this patch:

# time ./stress_reclaim_refault.sh
real 0m9.949s
user 0m0.496s
sys 14m44.974s

# time ./stress_reclaim_refault.sh
real 0m10.049s
user 0m0.486s
sys 14m55.791s

# time ./stress_reclaim_refault.sh
real 0m9.984s
user 0m0.481s
sys 14m53.841s

(2) A few runs with this patch:

# time ./stress_reclaim_refault.sh
real 0m9.885s
user 0m0.486s
sys 14m48.753s

# time ./stress_reclaim_refault.sh
real 0m9.903s
user 0m0.495s
sys 14m48.339s

# time ./stress_reclaim_refault.sh
real 0m9.861s
user 0m0.507s
sys 14m49.317s

I do not see any regressions from this patch. There is actually a very
slight improvement. If I have to guess, maybe it's because we avoid
the percpu loop in count_shadow_nodes() when calling
lruvec_page_state_local(), but I could not prove this using perf, it's
probably in the noise.

Let me know if the testing is satisfactory for you. I can send an
updated commit log accordingly with a summary of this conversation.

> > --
> > Michal Hocko
> > SUSE Labs

--000000000000967e290601f7d566
Content-Type: text/x-sh; charset="US-ASCII"; name="stress_reclaim_refault.sh"
Content-Disposition: attachment; filename="stress_reclaim_refault.sh"
Content-Transfer-Encoding: base64
Content-ID: <f_lku9s0ue0>
X-Attachment-Id: f_lku9s0ue0

IyEvYmluL2Jhc2gKCk5SX0NQVVM9JChnZXRjb25mIF9OUFJPQ0VTU09SU19PTkxOKQpOUl9DR1JP
VVBTPSQoKCBOUl9DUFVTICogMiApKQpURVNUX01CPTUwClRPVEFMX01CPSQoKFRFU1RfTUIgKiBO
Ul9DR1JPVVBTKSkKVE1QRlM9JChta3RlbXAgLWQpClJPT1Q9Ii9zeXMvZnMvY2dyb3VwLyIKWlJB
TV9ERVY9Ii9tbnQvZGV2dG1wZnMvenJhbTAiCgpjbGVhbnVwKCkgewogIHVtb3VudCAkVE1QRlMK
ICBybSAtcmYgJFRNUEZTCiAgZm9yIGkgaW4gJChzZXEgJE5SX0NHUk9VUFMpOyBkbwogICAgY2dy
b3VwPSIkUk9PVC9jZyRpIgogICAgcm1kaXIgJGNncm91cAogIGRvbmUKICBzd2Fwb2ZmICRaUkFN
X0RFVgogIGVjaG8gMSA+ICIvc3lzL2Jsb2NrL3pyYW0wL3Jlc2V0Igp9CnRyYXAgY2xlYW51cCBJ
TlQgUVVJVCBFWElUCgojIFNldHVwIHpyYW0KZWNobyAkKChUT1RBTF9NQiA8PCAyMCkpID4gIi9z
eXMvYmxvY2svenJhbTAvZGlza3NpemUiCm1rc3dhcCAkWlJBTV9ERVYKc3dhcG9uICRaUkFNX0RF
VgplY2hvICJTZXR1cCB6cmFtIGRvbmUiCgojIENyZWF0ZSBjZ3JvdXBzLCBzZXQgbGltaXRzCmVj
aG8gIittZW1vcnkiID4gIiRST09UL2Nncm91cC5zdWJ0cmVlX2NvbnRyb2wiCmZvciBpIGluICQo
c2VxICROUl9DR1JPVVBTKTsgZG8KICBjZ3JvdXA9IiRST09UL2NnJGkiCiAgbWtkaXIgJGNncm91
cAogIGVjaG8gJCgoIChURVNUX01CIDw8IDIwKSAvIDQpKSA+ICIkY2dyb3VwL21lbW9yeS5tYXgi
CmRvbmUKZWNobyAiU2V0dXAgY2dyb3VwcyBkb25lIgoKIyBTdGFydCB3b3JrZXJzIHRvIGFsbG9j
YXRlIHRtcGZzIG1lbW9yeQptb3VudCAtdCB0bXBmcyBub25lICRUTVBGUwpmb3IgaSBpbiAkKHNl
cSAkTlJfQ0dST1VQUyk7IGRvCiAgY2dyb3VwPSIkUk9PVC9jZyRpIgogIGY9IiRUTVBGUy90bXAk
aSIKICAoZWNobyAwID4gIiRjZ3JvdXAvY2dyb3VwLnByb2NzIiAmJgogICAgZGQgaWY9L2Rldi96
ZXJvIG9mPSRmIGJzPTFNIGNvdW50PSRURVNUX01CIHN0YXR1cz1ub25lICYmCiAgICBjYXQgJGYg
PiAvZGV2L251bGwpJgpkb25lCgojIFdhaXQgZm9yIHdvcmtlcnMKd2FpdAo=
--000000000000967e290601f7d566--
