Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 142861F6CB
	for <lists+cgroups@lfdr.de>; Wed, 15 May 2019 16:43:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727206AbfEOOnm (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 15 May 2019 10:43:42 -0400
Received: from mx1.redhat.com ([209.132.183.28]:45258 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726084AbfEOOnm (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Wed, 15 May 2019 10:43:42 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 5E40319CBCD;
        Wed, 15 May 2019 14:43:41 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.43.17.159])
        by smtp.corp.redhat.com (Postfix) with SMTP id 12C275C28E;
        Wed, 15 May 2019 14:43:38 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
        oleg@redhat.com; Wed, 15 May 2019 16:43:38 +0200 (CEST)
Date:   Wed, 15 May 2019 16:43:35 +0200
From:   Oleg Nesterov <oleg@redhat.com>
To:     Roman Gushchin <guro@fb.com>
Cc:     Tejun Heo <tj@kernel.org>, Alex Xu <alex_y_xu@yahoo.ca>,
        Kernel Team <Kernel-team@fb.com>,
        "cgroups@vger.kernel.org" <cgroups@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] signal: don't always leave task frozen after
 ptrace_stop()
Message-ID: <20190515144335.GC18892@redhat.com>
References: <20190513195517.2289671-1-guro@fb.com>
 <20190514160158.GB32459@redhat.com>
 <20190514174603.GB12629@tower.DHCP.thefacebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190514174603.GB12629@tower.DHCP.thefacebook.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.29]); Wed, 15 May 2019 14:43:41 +0000 (UTC)
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On 05/14, Roman Gushchin wrote:
>
> I agree that "may_remain_frozen" adds a lot of ugliness, so let's fix
> the regression with the unconditional leave_frozen(true). The patch below.
> Please, let me know if it's not what you meant.

Yes, thanks, this is what I meant. Feel free to add my ACK.

> so it's good only as a temporarily solution. But it looks like we agree here.

Yes, yes.

Oleg.

