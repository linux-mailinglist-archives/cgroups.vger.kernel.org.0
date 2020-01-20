Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 61AD6142CAE
	for <lists+cgroups@lfdr.de>; Mon, 20 Jan 2020 15:00:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726885AbgATOAi (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 20 Jan 2020 09:00:38 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:53749 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726738AbgATOAi (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 20 Jan 2020 09:00:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1579528837;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=YmtsJvNikQZ3zxiH/9D0rl/gNwQCHBkjzEkFAg43zNQ=;
        b=EcviU5z+o0JmkNHYPQcmsJSg+yK5uLh4g/WsalIhOt+Hw6iFVMQPfO/G6uiYn3DIoFte4x
        Q7KUBO+Otlxp/0LEzv4SKWlxicF75DMP3HeHei60y7ecf8klaurQXPsrUrlVmBN/HczDU9
        jODMPqWUoYWZ7eE51y9sM3L/V5/1KCA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-309-Lwt6HIVxN5-4dcK-qTBgWQ-1; Mon, 20 Jan 2020 09:00:34 -0500
X-MC-Unique: Lwt6HIVxN5-4dcK-qTBgWQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 92758DBA3;
        Mon, 20 Jan 2020 14:00:32 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.43.17.70])
        by smtp.corp.redhat.com (Postfix) with SMTP id B63FE84DB6;
        Mon, 20 Jan 2020 14:00:30 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
        oleg@redhat.com; Mon, 20 Jan 2020 15:00:32 +0100 (CET)
Date:   Mon, 20 Jan 2020 15:00:30 +0100
From:   Oleg Nesterov <oleg@redhat.com>
To:     Christian Brauner <christian.brauner@ubuntu.com>
Cc:     linux-api@vger.kernel.org, linux-kernel@vger.kernel.org,
        Tejun Heo <tj@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Li Zefan <lizefan@huawei.com>, cgroups@vger.kernel.org
Subject: Re: [PATCH v4 3/6] cgroup: refactor fork helpers
Message-ID: <20200120140029.GB30403@redhat.com>
References: <20200117181219.14542-1-christian.brauner@ubuntu.com>
 <20200117181219.14542-4-christian.brauner@ubuntu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200117181219.14542-4-christian.brauner@ubuntu.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

This is probably the only patch in series I can understand ;)

To me it looks like a good cleanup regardless, but

On 01/17, Christian Brauner wrote:
>
> The patch just passes in the parent task_struct

For what? "parent" is always "current", no?

Oleg.

