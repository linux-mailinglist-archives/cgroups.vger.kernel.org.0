Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D970B55C2BF
	for <lists+cgroups@lfdr.de>; Tue, 28 Jun 2022 14:47:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232949AbiF0IcM (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 27 Jun 2022 04:32:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232630AbiF0IcL (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 27 Jun 2022 04:32:11 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9801C6260;
        Mon, 27 Jun 2022 01:32:10 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id g20-20020a17090a579400b001ed52939d72so3257096pji.4;
        Mon, 27 Jun 2022 01:32:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=szaOjwym60f/8LOXYqQ6hITRb/YVPZeOicD4V048pqo=;
        b=NJafOd4qjIKqtOlocUHdmBBRJMZTiIDE9Gy+KP+BfbC2M2gFw1riyA4lEBuE/dAWix
         WhPNkbovuagZbKm0nCuWosFUIsHnS9h/OpK2eCNetrkuNknRM/DvtwyF/voZgdmOMYBV
         wVmEcUjC2IzelVFnbDfH6uj/hrEK2lANiE7wxTkS+2R/C801GBOeMZttPJXx24mKNx+h
         domxFmIBXvWRVrN+OlIQgm+jRLZn1quwrObi1sECH07N1mCqNXEQ1QoKgHQ4NoC4CKnG
         ZDEAQp69z2lDMPLiVFfvnL6g/xd6NjDKSB7WJE1xfF3WqXeJjCeNUIZTF+aSdhdG5b7Y
         QLBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=szaOjwym60f/8LOXYqQ6hITRb/YVPZeOicD4V048pqo=;
        b=f9lkKoXTyyNGYdg0JzZDMDJDZwb2hAvjJOYgwvvgTAt1oQ+vQ/XnehtPqOn9J6fENT
         nVSNdfi/+7QG+OxTTot72ZGchVgZYJCjr7juXVW3IPdYskCdWdGVYQq/wTDTt0dPDGea
         lRx4oYVxcopIdwr98wPtEFu2+9svLuHKFZ0y+ItdW/PisGKAEYo9zwlQkTBW6oFSz2pb
         cEQ/fcZaerVG/P0BAzv89MzJsGFab9YRdUyUYJcfyRubexD1ptLq3LhbdD5v8WSxqaMb
         qfwLiPKzn5zofTCSJ6cu+sJFxUG8AWhIFpZx7HCHNa5LIwctnn9RTlqhTRcI0+SkAvCy
         N9yA==
X-Gm-Message-State: AJIora8bhnDTTGmmNRpORRakZJ1x5oUDPG6dvCjluVHoNpI0p6g6+GUO
        yxQfD2GX8conIzv4z96hdZw=
X-Google-Smtp-Source: AGRyM1uk20Jy9YR5pX47qPcdlJGVOtE946CShXAvoAJl6peUUFXWAAC7gC2Xo57/Q4QFQgmfNkZ7lA==
X-Received: by 2002:a17:902:a505:b0:16b:7c53:9f02 with SMTP id s5-20020a170902a50500b0016b7c539f02mr4700268plq.19.1656318729985;
        Mon, 27 Jun 2022 01:32:09 -0700 (PDT)
Received: from localhost ([121.167.227.144])
        by smtp.gmail.com with ESMTPSA id u7-20020a17090a3fc700b001ecd3034b66sm8743744pjm.54.2022.06.27.01.32.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jun 2022 01:32:08 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Mon, 27 Jun 2022 17:32:06 +0900
From:   Tejun Heo <tj@kernel.org>
To:     Zhang Qiao <zhangqiao22@huawei.com>
Cc:     mingo@redhat.com, peterz@infradead.org,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        lizefan.x@bytedance.com, hannes@cmpxchg.org,
        cgroups@vger.kernel.org, lkml <linux-kernel@vger.kernel.org>,
        vschneid@redhat.com, dietmar.eggemann@arm.com, bristot@redhat.com,
        bsegall@google.com, Steven Rostedt <rostedt@goodmis.org>,
        mgorman@suse.de
Subject: Re: [Question] The system may be stuck if there is a cpu cgroup
 cpu.cfs_quato_us is very low
Message-ID: <YrlrBmF3oOfS3+fq@mtj.duckdns.org>
References: <5987be34-b527-4ff5-a17d-5f6f0dc94d6d@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5987be34-b527-4ff5-a17d-5f6f0dc94d6d@huawei.com>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Hello,

On Mon, Jun 27, 2022 at 02:50:25PM +0800, Zhang Qiao wrote:
> Becuase the task cgroup's cpu.cfs_quota_us is very small and
> test_fork's load is very heavy, the test_fork may be throttled long
> time, therefore, the cgroup_threadgroup_rw_sem read lock is held for
> a long time, other processes will get stuck waiting for the lock:

Yeah, this is a known problem and can happen with other locks too. The
solution prolly is only throttling while in or when about to return to
userspace. There is one really important and wide-spread assumption in
the kernel:

  If things get blocked on some shared resource, whatever is holding
  the resource ends up using more of the system to exit the critical
  section faster and thus unblocks others ASAP. IOW, things running in
  kernel are work-conserving.

The cpu bw controller gives the userspace a rather easy way to break
this assumption and thus is rather fundamentally broken. This is
basically the same problem we had with the old cgroup freezer
implementation which trapped threads in random locations in the
kernel.

So, right now, it's rather broken and can easily be used as an dos
attack vector.

Thanks.

-- 
tejun
