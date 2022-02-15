Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E12E94B645F
	for <lists+cgroups@lfdr.de>; Tue, 15 Feb 2022 08:30:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231330AbiBOHbC (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 15 Feb 2022 02:31:02 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:38440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233296AbiBOHa7 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 15 Feb 2022 02:30:59 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AD0610F23C;
        Mon, 14 Feb 2022 23:30:49 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 1A1B6B817DF;
        Tue, 15 Feb 2022 07:30:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F634C340EC;
        Tue, 15 Feb 2022 07:30:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1644910246;
        bh=d7O0LjAMCqSVPzrmAjEUAUrhTljBtokM4lMRkzTZRn4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=nI9BT8e7bH53D6xl7GN7ShLijc1GUvEbq4aQlISk6014ej3GYNqf5qP80x8gmm/C9
         0guWhIB8CG6B5zuHuf00vQIZDZHrwIIKCzcTJ9SwAxgKSiayqHfUjljXOt3LauL8UI
         VXdXc4rXKsY/KwXxCm704rsBDZEywjRr3as+lK1g=
Date:   Tue, 15 Feb 2022 08:30:43 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Suren Baghdasaryan <surenb@google.com>
Cc:     "T.J. Mercier" <tjmercier@google.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Jonathan Corbet <corbet@lwn.net>,
        Arve =?iso-8859-1?B?SGr4bm5lduVn?= <arve@android.com>,
        Todd Kjos <tkjos@android.com>,
        Martijn Coenen <maco@android.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Christian Brauner <brauner@kernel.org>,
        Hridya Valsaraju <hridya@google.com>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
        Benjamin Gaignard <benjamin.gaignard@linaro.org>,
        Liam Mark <lmark@codeaurora.org>,
        Laura Abbott <labbott@redhat.com>,
        Brian Starkey <Brian.Starkey@arm.com>,
        John Stultz <john.stultz@linaro.org>,
        Tejun Heo <tj@kernel.org>, Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Kalesh Singh <kaleshsingh@google.com>, Kenny.Ho@amd.com,
        DRI mailing list <dri-devel@lists.freedesktop.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-media <linux-media@vger.kernel.org>,
        "moderated list:DMA BUFFER SHARING FRAMEWORK" 
        <linaro-mm-sig@lists.linaro.org>,
        cgroups mailinglist <cgroups@vger.kernel.org>
Subject: Re: [RFC v2 6/6] android: binder: Add a buffer flag to relinquish
 ownership of fds
Message-ID: <YgtWo+6UeAU4/CvT@kroah.com>
References: <20220211161831.3493782-1-tjmercier@google.com>
 <20220211161831.3493782-7-tjmercier@google.com>
 <Ygdfe3XSvN8iFuUc@kroah.com>
 <CABdmKX1eKZZ9809uxnzT_Bm+mdNuK2AObLRxyBpdDF3yE76Hrg@mail.gmail.com>
 <YgtPzXUmSOVyplnm@kroah.com>
 <CAJuCfpG0V2qZVVUPRmw3fZP-bQmp+w36nOUe9iHtgmuHb7PemQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJuCfpG0V2qZVVUPRmw3fZP-bQmp+w36nOUe9iHtgmuHb7PemQ@mail.gmail.com>
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Mon, Feb 14, 2022 at 11:19:35PM -0800, Suren Baghdasaryan wrote:
> On Mon, Feb 14, 2022 at 11:01 PM Greg Kroah-Hartman
> <gregkh@linuxfoundation.org> wrote:
> >
> > On Mon, Feb 14, 2022 at 02:25:47PM -0800, T.J. Mercier wrote:
> > > On Fri, Feb 11, 2022 at 11:19 PM Greg Kroah-Hartman
> > > > > --- a/include/uapi/linux/android/binder.h
> > > > > +++ b/include/uapi/linux/android/binder.h
> > > > > @@ -137,6 +137,7 @@ struct binder_buffer_object {
> > > > >
> > > > >  enum {
> > > > >       BINDER_BUFFER_FLAG_HAS_PARENT = 0x01,
> > > > > +     BINDER_BUFFER_FLAG_SENDER_NO_NEED = 0x02,
> > > > >  };
> > > > >
> > > > >  /* struct binder_fd_array_object - object describing an array of fds in a buffer
> > > > > --
> > > > > 2.35.1.265.g69c8d7142f-goog
> > > > >
> > > >
> > > > How does userspace know that binder supports this new flag?
> > >
> > > Sorry, I don't completely follow even after Todd's comment. Doesn't
> > > the presence of BINDER_BUFFER_FLAG_SENDER_NO_NEED in the header do
> > > this?
> >
> > There is no "header" when running a new kernel on an old userspace,
> > right?  How about the other way around, old kernel, new userspace?
> 
> 1. new kernel + old userspace = kernel supports the feature but
> userspace does not use it. The old userspace won't even mount the new
> cgroup controller, accounting is not performed, charge is not
> transferred.
> 2. old kernel + new userspace = the new cgroup controller is not
> supported by the kernel, accounting is not performed, charge is not
> transferred.
> 3. old kernel + old userspace = same as #2
> 4. new kernel + new userspace = cgroup is mounted, feature is
> supported and used.
> Does that work or do we need a separate indication of whether binder
> driver supports the charge transfer feature?

Ok, if that's all working, this is fine, it just seemed odd to add a new
type like this.  Perhaps this can go into the changelog text...

thanks,

greg k-h
