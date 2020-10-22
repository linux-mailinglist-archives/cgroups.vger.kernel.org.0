Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8F26A296654
	for <lists+cgroups@lfdr.de>; Thu, 22 Oct 2020 22:59:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S372124AbgJVU7r (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 22 Oct 2020 16:59:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S372101AbgJVU7o (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 22 Oct 2020 16:59:44 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DA0DC0613CE
        for <cgroups@vger.kernel.org>; Thu, 22 Oct 2020 13:59:44 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: krisman)
        with ESMTPSA id D457D1F45E92
From:   Gabriel Krisman Bertazi <krisman@collabora.com>
To:     tj@kernel.org
Cc:     axboe@kernel.dk, cgroups@vger.kernel.org, khazhy@google.com,
        kernel@collabora.com
Subject: Re: [PATCH v2 1/2] blk-cgroup: Fix memleak on error path
Organization: Collabora
References: <20201022205758.1739430-1-krisman@collabora.com>
Date:   Thu, 22 Oct 2020 16:59:39 -0400
In-Reply-To: <20201022205758.1739430-1-krisman@collabora.com> (Gabriel Krisman
        Bertazi's message of "Thu, 22 Oct 2020 16:57:57 -0400")
Message-ID: <87k0vi0yf8.fsf@collabora.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Gabriel Krisman Bertazi <krisman@collabora.com> writes:

> If new_blkg allocation raced with blk_policy change and
> blkg_lookup_check fails, new_blkg is leaked.

hm, sorry for the duplicate, the first attempt my script tripped on the
cover letter for some reason. Please disregard this one.

-- 
Gabriel Krisman Bertazi
