Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B1BD943B05
	for <lists+cgroups@lfdr.de>; Thu, 13 Jun 2019 17:25:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731556AbfFMPZV convert rfc822-to-8bit (ORCPT
        <rfc822;lists+cgroups@lfdr.de>); Thu, 13 Jun 2019 11:25:21 -0400
Received: from mx2.suse.de ([195.135.220.15]:58232 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731550AbfFMMCf (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Thu, 13 Jun 2019 08:02:35 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 5105AAF19;
        Thu, 13 Jun 2019 12:02:33 +0000 (UTC)
Date:   Thu, 13 Jun 2019 14:02:29 +0200
From:   Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>
To:     Joel Savitz <jsavitz@redhat.com>
Cc:     Li Zefan <lizefan@huawei.com>, Tejun Heo <tj@kernel.org>,
        Waiman Long <longman@redhat.com>, Phil Auld <pauld@redhat.com>,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] cpuset: restore sanity to
 cpuset_cpus_allowed_fallback()
Message-ID: <20190613120228.GA26668@blackbody.suse.cz>
References: <20190409204003.6428-1-jsavitz@redhat.com>
 <20190521143414.GJ5307@blackbody.suse.cz>
 <CAL1p7m6nfPkWoEEAjO+Gxq-ZiRY7+1jU_7dVcw2-hjC22xz-4A@mail.gmail.com>
 <20190528121036.GC31588@blackbody.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
In-Reply-To: <20190528121036.GC31588@blackbody.suse.cz>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Tue, May 28, 2019 at 02:10:37PM +0200, Michal Koutný  <MKoutny@suse.com> wrote:
> Although, on v1 we will lose the "no longer affine to..." message
> (which is what happens in your demo IIUC).
FWIW, I was wrong, off by one 'state' transition. So the patch doesn't
cause change in messaging (not tested though).
