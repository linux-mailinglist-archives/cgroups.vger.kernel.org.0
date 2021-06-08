Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 11BB93A02EE
	for <lists+cgroups@lfdr.de>; Tue,  8 Jun 2021 21:22:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236780AbhFHTLQ (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 8 Jun 2021 15:11:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236136AbhFHTIz (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 8 Jun 2021 15:08:55 -0400
Received: from mail-qk1-x735.google.com (mail-qk1-x735.google.com [IPv6:2607:f8b0:4864:20::735])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91230C061149;
        Tue,  8 Jun 2021 12:01:07 -0700 (PDT)
Received: by mail-qk1-x735.google.com with SMTP id u30so21264504qke.7;
        Tue, 08 Jun 2021 12:01:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=tyj1ti03dIMK1ozRhjYuzmAR0/ZNP3Nds6icyKCHFlQ=;
        b=aquonKpFpgW+meXELKk7PeP2BVEA64UDJBDwLTmHutu10dBUUYxGnxY/IIjgPhz1tZ
         YvU/9lSBFDD5nca8ydmknI4+DI0UMUvW5frN06/dfKwmSQYvoUBddPuKk+wCm2Fut1aS
         s/BhxnBO6tXrWGLaNJzeglvRX7Yf4f+cIkry6stGacZIGLeqgQUXTjKsK9tXFlnK0fh4
         dT4pcL2b5cHyY3b9OZtOlT2P12Uk2v3gfGx0NqxpvOMc4osp/8IdJLF8ukCPfbJQN1ph
         w9rpiWsMk6qxYup0HnG0vl4Y5b1frD11laPoGhDn7EIXl4m67RBRitzQURMiI2Bvkh29
         E0iA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=tyj1ti03dIMK1ozRhjYuzmAR0/ZNP3Nds6icyKCHFlQ=;
        b=MGo6/dqNZ/OwgsZnzVBDYHlt1jxBZr7M+AYEzn5aedxWw8xD2TAWz5OpwHktcyL5Cg
         MJ6BkvKatcvGx7VjOjiv3fU1CVeww70KZ19xXByWHQp2Trqbpx/2aBuiGUxqkYXeuy0N
         bV3ZSfhZNRJkcaRa/gsddETzJrHW4PkdAJQ2t9nQke5eUB++jgAxJlAomxI0E+EYODsk
         7K4zSQOZmkh+qMYkBGfvOpBCfe4VWwlY40f49WHCTnkbqz20u/Te6rz/6AvZuM9DL0DM
         tCHRTPq30Uw5zpBR/ch3lu54XBhrBzDkBDhecqHM0k/6O+M6Vsp6ztzI7eQs3qudMqLh
         FIhw==
X-Gm-Message-State: AOAM532fgbCJfEwtTV4fler9ri6mwrecsWIEbKYyIanZZpCZk8YQYmbE
        oSGRuUjMMDHSOyelDg+LhRg=
X-Google-Smtp-Source: ABdhPJwipmZzBXCdpz+kuF92MD2gopIukii17l8upDYLoD+HlPR/OmSTF++k04VMS7IBUeHkV4Vokw==
X-Received: by 2002:a37:e215:: with SMTP id g21mr1954570qki.37.1623178866256;
        Tue, 08 Jun 2021 12:01:06 -0700 (PDT)
Received: from localhost ([199.192.137.73])
        by smtp.gmail.com with ESMTPSA id k13sm12519911qki.24.2021.06.08.12.01.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Jun 2021 12:01:05 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Tue, 8 Jun 2021 15:01:05 -0400
From:   Tejun Heo <tj@kernel.org>
To:     Suren Baghdasaryan <surenb@google.com>
Cc:     hannes@cmpxchg.org, lizefan.x@bytedance.com, mingo@redhat.com,
        peterz@infradead.org, shakeelb@google.com, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        minchan@kernel.org, corbet@lwn.net, bristot@redhat.com,
        paulmck@kernel.org, rdunlap@infradead.org,
        akpm@linux-foundation.org, tglx@linutronix.de, macro@orcam.me.uk,
        viresh.kumar@linaro.org, mike.kravetz@oracle.com,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        cgroups@vger.kernel.org, kernel-team@android.com
Subject: Re: [PATCH v3 1/1] cgroup: make per-cgroup pressure stall tracking
 configurable
Message-ID: <YL++cWuetMvfx9Tf@slm.duckdns.org>
References: <20210524195339.1233449-1-surenb@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210524195339.1233449-1-surenb@google.com>
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Mon, May 24, 2021 at 12:53:39PM -0700, Suren Baghdasaryan wrote:
> PSI accounts stalls for each cgroup separately and aggregates it at each
> level of the hierarchy. This causes additional overhead with psi_avgs_work
> being called for each cgroup in the hierarchy. psi_avgs_work has been
> highly optimized, however on systems with large number of cgroups the
> overhead becomes noticeable.
> Systems which use PSI only at the system level could avoid this overhead
> if PSI can be configured to skip per-cgroup stall accounting.
> Add "cgroup_disable=pressure" kernel command-line option to allow
> requesting system-wide only pressure stall accounting. When set, it
> keeps system-wide accounting under /proc/pressure/ but skips accounting
> for individual cgroups and does not expose PSI nodes in cgroup hierarchy.
> 
> Signed-off-by: Suren Baghdasaryan <surenb@google.com>

Applied to cgroup/for-5.14.

Thanks.

-- 
tejun
