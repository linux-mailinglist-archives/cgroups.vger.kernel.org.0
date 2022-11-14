Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5B99628C43
	for <lists+cgroups@lfdr.de>; Mon, 14 Nov 2022 23:44:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237701AbiKNWoM (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 14 Nov 2022 17:44:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237735AbiKNWoD (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 14 Nov 2022 17:44:03 -0500
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9E88B867;
        Mon, 14 Nov 2022 14:43:59 -0800 (PST)
Received: by mail-pf1-x42a.google.com with SMTP id z26so12451241pff.1;
        Mon, 14 Nov 2022 14:43:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0RkJm12EG/9E1zu6+WxpU+WvUvpr5g7TNGosiBHQiqs=;
        b=jYAlB6T2TOHN4HHkErKWne7mc4i/zPhe9R0lfnOngKXiyPq+Thno7P922IY0g2Drfo
         zvMAURArSuTKAOkCVgvtw8DdpP+waWCjdJVBV2MPvJy0U5fEMxvbv9oJU1Yvqvi7ZwI3
         MdCzo2QiIy6QfCkY9NXyfO4WARTbk2aCPgkra7SKKT7OVnq7mo/yQ3s47NIWmF0M3SaV
         C4SM8YaSmL44dmp3qy76n+uT0BGCC8pfD9cjtdrWJ3byNruYi7ZjKZuPsdpRO+DRhhrW
         YjkTPG+8ov3sd+PIIwOneVmRl54qzgpz4b1UL6k4R+WAm4RtjtG//UAJlWK7/IlY0iGU
         xAtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0RkJm12EG/9E1zu6+WxpU+WvUvpr5g7TNGosiBHQiqs=;
        b=agQD7C2Vya5zCmw1vX++NTq8JS9rNDghAHOr15Afa7+rE24GEzk+iQFMQbhRdHhyEK
         st/cPani+ARFC8YMLs3NRMPA2CLpXEBYXHNNDBLhxrMW9fH1IEvLHSt69EA1nOYtHuEB
         j8FJWmtX9AYGspM4RvEMK4M7zjK/EAH3/96YolELK5whkDF2Vz4Mes7ROR7PCUN7IL4D
         qOoKVDZYeVO1up+G1KojeJnJRLA2txYyXsWnTy8nJ5jlDE8VEmYlCjOZLGkRt3MGuPlm
         fgivQ0PnKFjBkz1pweO6VcT8yFg5GSU/aJ+lu5iF8MgiLrZ/32kqLa+TXwwtiVQrNpAH
         awQA==
X-Gm-Message-State: ANoB5pmRRqR0YCBVb2/K984sFA+IaWMYXDd3ySystnX1Q6DnLx9zTeSI
        KBQZy0zg6goC9xfwkZAgpjw=
X-Google-Smtp-Source: AA0mqf7lxEb0AxXbQvRejZp/swbVSzCxMl3BbaFVMt0CGZXBh+TOySlOfwrJwHd4vyTH5k4jO2VSJA==
X-Received: by 2002:aa7:8155:0:b0:572:725f:33e6 with SMTP id d21-20020aa78155000000b00572725f33e6mr188590pfn.46.1668465838739;
        Mon, 14 Nov 2022 14:43:58 -0800 (PST)
Received: from localhost (2603-800c-1a02-1bae-a7fa-157f-969a-4cde.res6.spectrum.com. [2603:800c:1a02:1bae:a7fa:157f:969a:4cde])
        by smtp.gmail.com with ESMTPSA id l2-20020a635702000000b0046ec057243asm6258029pgb.12.2022.11.14.14.43.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Nov 2022 14:43:58 -0800 (PST)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Mon, 14 Nov 2022 12:43:57 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Waiman Long <longman@redhat.com>
Cc:     Jens Axboe <axboe@kernel.dk>, cgroups@vger.kernel.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Ming Lei <ming.lei@redhat.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>,
        Hillf Danton <hdanton@sina.com>
Subject: Re: [PATCH v10 3/3] blk-cgroup: Flush stats at blkgs destruction path
Message-ID: <Y3LErVJiFL9wSGGl@slm.duckdns.org>
References: <20221105005902.407297-1-longman@redhat.com>
 <20221105005902.407297-4-longman@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221105005902.407297-4-longman@redhat.com>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Fri, Nov 04, 2022 at 08:59:02PM -0400, Waiman Long wrote:
> As noted by Michal, the blkg_iostat_set's in the lockless list
> hold reference to blkg's to protect against their removal. Those
> blkg's hold reference to blkcg. When a cgroup is being destroyed,
> cgroup_rstat_flush() is only called at css_release_work_fn() which is
> called when the blkcg reference count reaches 0. This circular dependency
> will prevent blkcg from being freed until some other events cause
> cgroup_rstat_flush() to be called to flush out the pending blkcg stats.
> 
> To prevent this delayed blkcg removal, add a new cgroup_rstat_css_flush()
> function to flush stats for a given css and cpu and call it at the blkgs
> destruction path, blkcg_destroy_blkgs(), whenever there are still some
> pending stats to be flushed. This will ensure that blkcg reference
> count can reach 0 ASAP.
> 
> Signed-off-by: Waiman Long <longman@redhat.com>

Acked-by: Tejun Heo <tj@kernel.org>

Thanks.

-- 
tejun
