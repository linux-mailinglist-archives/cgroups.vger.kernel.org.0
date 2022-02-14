Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7538B4B5616
	for <lists+cgroups@lfdr.de>; Mon, 14 Feb 2022 17:25:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349947AbiBNQYK (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 14 Feb 2022 11:24:10 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:35742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243769AbiBNQYJ (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 14 Feb 2022 11:24:09 -0500
Received: from mail-qk1-x729.google.com (mail-qk1-x729.google.com [IPv6:2607:f8b0:4864:20::729])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 841C450B23
        for <cgroups@vger.kernel.org>; Mon, 14 Feb 2022 08:24:01 -0800 (PST)
Received: by mail-qk1-x729.google.com with SMTP id de39so5269160qkb.13
        for <cgroups@vger.kernel.org>; Mon, 14 Feb 2022 08:24:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=7iaUyRhGkUA7PAMU1c+vAYFq1GgavVmjQYa91iIOiFk=;
        b=q98xAfK0lidrBW3RZafWMOaYOlDwjN3XqwR4nUA67A2As9jAY5LV1kUhegVVmDYwtb
         GId+u1ckugUhdD9kAIdvECoq8vwbT/sHhuME55ExdOiMAMM+OpkQcEJQQtGZ3s7ykrfr
         pWuk815AxI31/odpXIjDXdn0Odh7mfoPzjVlpHfzki+pC0g/UCgw3nwiL7XHxUx+VBbZ
         27IXTcBAugv13y4UIonMdIDwbH9XteHNVuBBoO1xLrYjcKtxz7t68G5FH3zShns/WMRB
         cgzXsnsjuDQOcm7VBzmMYhqkpcqoDuhyjShjXrMDg5bm0wdOsjQMvnUOnmjVqcCEUnqr
         n49g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=7iaUyRhGkUA7PAMU1c+vAYFq1GgavVmjQYa91iIOiFk=;
        b=1ObLdfib3VJ3SiMPFciFYdlggQT4PVGgNKr+OVZRXoOmZHD3ltpXUoRKE6aZGikp2X
         nicTzj8gtRYr1GCvd0sxkevDV+uLnulycWWlpCuiCuIpVr/zjEWkkI22O1i6zwKftiBJ
         xvMPPTpBdoKHrwPbpPMDrIDzWEjLc4PkRW2u61HaiMHaDjGEvXkyCgXGvRY3TrJWdT3u
         7eiMMTrpfr7687NyQJLRegj3UJ2AvSQYvhgKIowiAuK4RcDWUDdMdiUokYMlj7EGDdWS
         ku9PNoi5eynSbWBlcSirnPThraTfYHCPDCo2iignhZietk2lc2+iXbdNMDd8VQXeXBma
         658w==
X-Gm-Message-State: AOAM531v1TLGdM8o3/Wcd6gM47D3OhT4g5U3rraWKTMe8na/rH6ZuA65
        amI6D5YypdWfVUYf8xJ8cWdvlA==
X-Google-Smtp-Source: ABdhPJxCQ4pOe2LcxncfXXWHc4uofZU2gHJXA1m/sV0t9bbpJUUfRPvT88isowkQTLvT38CqAyTVYQ==
X-Received: by 2002:a37:9e10:: with SMTP id h16mr228154qke.155.1644855840764;
        Mon, 14 Feb 2022 08:24:00 -0800 (PST)
Received: from localhost (cpe-98-15-154-102.hvc.res.rr.com. [98.15.154.102])
        by smtp.gmail.com with ESMTPSA id f20sm18767451qte.14.2022.02.14.08.24.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Feb 2022 08:24:00 -0800 (PST)
Date:   Mon, 14 Feb 2022 11:23:59 -0500
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     cgroups@vger.kernel.org, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@kernel.org>,
        Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Waiman Long <longman@redhat.com>
Subject: Re: [PATCH v2 2/4] mm/memcg: Disable threshold event handlers on
 PREEMPT_RT
Message-ID: <YgqCH1CcutS8Z2wU@cmpxchg.org>
References: <20220211223537.2175879-1-bigeasy@linutronix.de>
 <20220211223537.2175879-3-bigeasy@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220211223537.2175879-3-bigeasy@linutronix.de>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Fri, Feb 11, 2022 at 11:35:35PM +0100, Sebastian Andrzej Siewior wrote:
> During the integration of PREEMPT_RT support, the code flow around
> memcg_check_events() resulted in `twisted code'. Moving the code around
> and avoiding then would then lead to an additional local-irq-save
> section within memcg_check_events(). While looking better, it adds a
> local-irq-save section to code flow which is usually within an
> local-irq-off block on non-PREEMPT_RT configurations.
> 
> The threshold event handler is a deprecated memcg v1 feature. Instead of
> trying to get it to work under PREEMPT_RT just disable it. There should
> be no users on PREEMPT_RT. From that perspective it makes even less
> sense to get it to work under PREEMPT_RT while having zero users.
> 
> Make memory.soft_limit_in_bytes and cgroup.event_control return
> -EOPNOTSUPP on PREEMPT_RT. Make an empty memcg_check_events() and
> memcg_write_event_control() which return only -EOPNOTSUPP on PREEMPT_RT.
> Document that the two knobs are disabled on PREEMPT_RT.
> 
> Suggested-by: Michal Hocko <mhocko@kernel.org>
> Suggested-by: Michal Koutný <mkoutny@suse.com>
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

Acked-by: Johannes Weiner <hannes@cmpxchg.org>
