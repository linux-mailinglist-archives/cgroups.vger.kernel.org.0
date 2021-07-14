Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2643D3C7F7B
	for <lists+cgroups@lfdr.de>; Wed, 14 Jul 2021 09:43:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238314AbhGNHq2 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 14 Jul 2021 03:46:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:59216 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238139AbhGNHq1 (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Wed, 14 Jul 2021 03:46:27 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 42700613B2;
        Wed, 14 Jul 2021 07:43:35 +0000 (UTC)
Date:   Wed, 14 Jul 2021 09:43:30 +0200
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     Vasily Averin <vvs@virtuozzo.com>
Cc:     cgroups@vger.kernel.org, Michal Hocko <mhocko@kernel.org>,
        Serge Hallyn <serge@hallyn.com>, Roman Gushchin <guro@fb.com>
Subject: Re: [PATCH] memcg: enable accounting for pids in nested pid
 namespaces
Message-ID: <20210714074330.eoug2b7hno3heoeb@wittgenstein>
References: <7b777e22-5b0d-7444-343d-92cbfae5f8b4@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <7b777e22-5b0d-7444-343d-92cbfae5f8b4@virtuozzo.com>
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Thu, Apr 22, 2021 at 08:44:15AM +0300, Vasily Averin wrote:
> init_pid_ns.pid_cachep have enabled memcg accounting, though this
> setting was disabled for nested pid namespaces.
> 
> Signed-off-by: Vasily Averin <vvs@virtuozzo.com>
> ---

Not sure I already acked this but looks good,
Acked-by: Christian Brauner <christian.brauner@ubuntu.com>
