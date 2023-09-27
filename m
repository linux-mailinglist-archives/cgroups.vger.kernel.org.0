Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6FC5E7B0B2B
	for <lists+cgroups@lfdr.de>; Wed, 27 Sep 2023 19:38:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229458AbjI0Ri4 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 27 Sep 2023 13:38:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbjI0Ri4 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 27 Sep 2023 13:38:56 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B9D9A1;
        Wed, 27 Sep 2023 10:38:54 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 25468C433C8;
        Wed, 27 Sep 2023 17:38:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1695836334;
        bh=HKzliITSy3AFhtAL3WhlVsFSbGRUnpk80CAjnR77v+g=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=q1Pz6N+Fm+kYs+b4ntL+nJLDkyyar3+pKrJ3zJ8AAbPSv75EvnXJ2shHiKavACKks
         JR9dngl0ylNNVkE/UAvJvy1ghHEg52dgmuHdoc9fY85Nhs9JFEaV+mXXUJSVt3sjsH
         pl7pAdmFPKMEZD6pCSizdhi77hCzC1Z9EvHeu/EE=
Date:   Wed, 27 Sep 2023 10:38:52 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Huan Yang <link@vivo.com>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Shakeel Butt <shakeelb@google.com>,
        Muchun Song <muchun.song@linux.dev>,
        Suleiman Souhlal <suleiman@google.com>,
        Mike Rapoport <rppt@kernel.org>,
        "Jan Alexander Steffens (heftig)" <heftig@archlinux.org>,
        Yu Zhao <yuzhao@google.com>, Brian Geffon <bgeffon@google.com>,
        Gaosheng Cui <cuigaosheng1@huawei.com>,
        Peter Xu <peterx@redhat.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        "T.J. Alumbaugh" <talumbau@google.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, cgroups@vger.kernel.org, kernel@vivo.com
Subject: Re: [PATCH 0/3] Per memcg lru_gen node stat
Message-Id: <20230927103852.971afee31402fceb5f0fa529@linux-foundation.org>
In-Reply-To: <20230914104754.55-1-link@vivo.com>
References: <20230914104754.55-1-link@vivo.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Thu, 14 Sep 2023 18:47:42 +0800 Huan Yang <link@vivo.com> wrote:

> On original global lru_gen node in debugfs, it can all show each memcg's
> lru gen info in "lru_gen" or "lru_gen_full", and can type cmd into lru_gen.
> But which show info contains all memcg's info, and cmd need to 
> know memcg's id.
> 
> This patchset add lru_gen node in per memcg, with this node, we can
> get lru_gen info in each memcg.
> Also, we can type cmd to control each memcg's lru_gen seq, but, this node
> don't support multi cmd, single memcg just process one cmd once time.

Strangely, I cannot find this series in my linux-mm archive.  They came
through in linux-kernel however.

Perhaps a resend will help move things along, thanks.
