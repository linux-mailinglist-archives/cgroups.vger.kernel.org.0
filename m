Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39A4C53AF5F
	for <lists+cgroups@lfdr.de>; Thu,  2 Jun 2022 00:50:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231523AbiFAV2s (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 1 Jun 2022 17:28:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231494AbiFAV2r (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 1 Jun 2022 17:28:47 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C28B46464;
        Wed,  1 Jun 2022 14:28:45 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id a10so3165892pju.3;
        Wed, 01 Jun 2022 14:28:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=XQUrno1u9BV9Hi8T4VSHF83kGe0TWlPtBJS9T7agQLs=;
        b=TMHlWNZfuujpslCtDUUYYkHjwexELIZXoM27hvWYqwVGP7r+7+3QJic0aHrV85RFxb
         tV8dJpD3fRLSfqZNqHIhLHW/vHaCZdxoMezRb6P7DxvsFrZZsY1TzA8898q+xCdiUW4E
         7QZX+Fyyot2d9D50TXYm5UKZ/Nd610xlj6uglmx8VFXyGIn3dw3XZkx70uSMXxIWrWIp
         DTWy4C7wliyAluKxGQ08T++L7+4XuppeWncfyJZqxOgnWkfIF4RpylCD6D11SmBTV3QN
         qiNuxGrWpXl3ix2Duf6XNEU8xrDF6udyOeO8niAseUGoQViv4yUXScbTQeA/MAdx+ek5
         Zgag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=XQUrno1u9BV9Hi8T4VSHF83kGe0TWlPtBJS9T7agQLs=;
        b=LgLt//0N4TZ5A0FN2nZFx2AITtXg6kOgJIVzhZ02CWRt3UhSCccqX73tSvlirjUoy4
         X85DIE3MSC4fLsPb/m9algU82l4cWuBeG/9HYvFWRsFSIuT8heWMsl/gq8CyLTtCWdzD
         11jWPdtKR0S+DlZrmjCqQP718220ml1W9hEYqR5Nu9x9U22xrta2HAOmNnAQYn+Sbcuo
         YhvmsUXjNFXpIdIyccMkxMJLe5+xjT0m7SrdDK5XlMCdQjLtTrLbJMggK+BXv6Gp0PxK
         pkihN+XoAEEekmn31F+oH/dDuGP9RaObRFAkApZRkrRuV5mkB2zdYOaURsmU8bUsxZHv
         f32w==
X-Gm-Message-State: AOAM532EN3j2v+s8YBv+lHrTXCWjA77HbxZNFxK48ajGATlT8/ngzXym
        wDr2EKk3snBZafGShEYlBAM3ZPcYbKU=
X-Google-Smtp-Source: ABdhPJwM5zz2uYne2MAC7ir90ZqtkcM2nG4zHU895tHlRX0Kj6k0imNtWWz7kXaM9VIgrm55e31B4A==
X-Received: by 2002:a17:902:7b93:b0:162:bc8:935a with SMTP id w19-20020a1709027b9300b001620bc8935amr1429517pll.44.1654118925185;
        Wed, 01 Jun 2022 14:28:45 -0700 (PDT)
Received: from localhost (2603-800c-1a02-1bae-a7fa-157f-969a-4cde.res6.spectrum.com. [2603:800c:1a02:1bae:a7fa:157f:969a:4cde])
        by smtp.gmail.com with ESMTPSA id r16-20020a635150000000b003f65560a1a7sm1773188pgl.53.2022.06.01.14.28.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Jun 2022 14:28:44 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Wed, 1 Jun 2022 11:28:43 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Waiman Long <longman@redhat.com>
Cc:     Jens Axboe <axboe@kernel.dk>, cgroups@vger.kernel.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Ming Lei <ming.lei@redhat.com>
Subject: Re: [PATCH v2 2/2] blk-cgroup: Optimize blkcg_rstat_flush()
Message-ID: <YpfaC+wB5Th4tLDY@slm.duckdns.org>
References: <20220601165324.60892-1-longman@redhat.com>
 <20220601165324.60892-2-longman@redhat.com>
 <YpemVpvaPomwH7mt@slm.duckdns.org>
 <ca091a5c-4ae1-e973-403e-4086d4527102@redhat.com>
 <YpexWFptr/l2Y0rU@slm.duckdns.org>
 <bca31669-7107-ebe4-7fbf-2449940a5cc8@redhat.com>
 <c26f153c-304c-e109-6626-bb8b79a2e2ad@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c26f153c-304c-e109-6626-bb8b79a2e2ad@redhat.com>
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

On Wed, Jun 01, 2022 at 05:25:53PM -0400, Waiman Long wrote:
> I think the best way to protect against blkg destruction is to get a percpu
> reference when put into lockless list and put it back when removed.
> 
> BTW, when I ran a test that continuously create and destroy containers, the
> total number of blkcg's kept on increasing. There are some freeing of
> blkcg's but no freeing of blkg's at all. Maybe we have a similar dying
> blkcg's problem here. I will take a further look at that when I have time.

They get pinned by per-cgroup writebacks which gets pinned by lingering page
cache and other remaining accounted memory areas, so I think they can hang
around if there's no memory pressure. But, yeah, it'd be great to verify
that they actually go away under memory pressure.

Thanks.

-- 
tejun
